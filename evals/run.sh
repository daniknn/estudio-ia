#!/bin/sh
# Evals del plugin estudio-ia. Corre cada caso N veces en modo headless (claude -p) sobre una copia
# fresca de fixtures/espacio (o un directorio vacío) en un directorio temporal, sin MCP.
# Uso:  sh evals/run.sh [N=5] [casos...]     (por defecto: todos los de casos/)
#       J=4 (corridas en paralelo), LIMITE_USD=58 (corta la suite al pasarse), MODELO=sonnet,
#       OUT=<dir> (dónde dejar salidas), RESULTADOS=<archivo>, CLAUDE_BIN=claude,
#       REUSAR=1 con OUT=<dir de una corrida previa>: no llama a claude, solo vuelve a correr check.sh
#       sobre las salidas guardadas (sirve para afinar un check sin gastar).
# Nunca se usan MCP: --strict-mcp-config sin --mcp-config y --setting-sources project,local
# (no se cargan plugins, skills ni CLAUDE.md del usuario; solo el plugin bajo prueba).
# Requiere una sesión válida de Claude Code. Licencia MIT.
HERE=$(cd "$(dirname "$0")" && pwd)
RAIZ=$(dirname "$HERE")
CLAUDE_BIN=${CLAUDE_BIN:-claude}
export LC_ALL=en_US.UTF-8
MODELO=${MODELO:-sonnet}
J=${J:-4}
LIMITE_USD=${LIMITE_USD:-58}
RESULTADOS=${RESULTADOS:-$HERE/RESULTADOS.md}

# Notas que se agregan a los prompts: cada corrida es de un solo turno y nadie contesta.
NOTA_A="[Corrida de evaluación automática de un solo turno: nadie te contestará. Estas son todas mis respuestas, ya completas, y ya confirmo todo lo que vayas a mostrar: no hagas preguntas, no pidas confirmación y haz el trabajo ahora, escribiendo los archivos que corresponda. Si te falta un dato que solo yo sé, no lo inventes: déjalo omitido.]"
NOTA_P="[Corrida de evaluación automática de un solo turno: nadie te contestará. Si necesitas preguntar algo, haz tu única pregunta (o la oferta que te toque) y detente.]"

if [ "$1" = "--uno" ]; then
  OUT=$2; caso=$3; i=$4
  d=$OUT/$caso-$i; mkdir -p "$d"; dir=$d/espacio
  if [ -n "$REUSAR" ]; then
    [ -f "$d/salida.jsonl" ] || exit 0
    FIXTURE=espacio; . "$HERE/casos/$caso.sh"
    sub=$(jq -r 'select(.type=="result") | .subtype' "$d/salida.jsonl" 2>/dev/null | tail -1)
    if [ "$sub" != success ]; then echo "error: la corrida terminó con ${sub:-sin resultado}" > "$d/res.txt"
    else sh "$HERE/check.sh" "$caso" "$dir" "$d/salida.jsonl" > "$d/res.txt" 2>&1; fi
    exit 0
  fi
  gasto=$(cat "$OUT"/*/costo.txt 2>/dev/null | awk '{s+=$1} END{printf "%.2f", s}')
  if [ "$(echo "$gasto $LIMITE_USD" | awk '{print ($1>$2)}')" = 1 ]; then
    echo "error: omitida, la suite ya gastó USD $gasto" > "$d/res.txt"; echo 0 > "$d/costo.txt"; exit 0
  fi
  FIXTURE=espacio TOOLS="Bash,Write,Edit,Read,Skill"; BUDGET=1
  . "$HERE/casos/$caso.sh"
  if [ "$FIXTURE" = vacio ]; then mkdir -p "$dir"; else cp -R "$HERE/fixtures/$FIXTURE" "$dir"; fi
  setup "$dir"
  (cd "$dir" && find . -type f ! -name .DS_Store -exec shasum {} + | sort -k2) > "$d/antes.txt"
  # shellcheck disable=SC2086
  (cd "$dir" && "$CLAUDE_BIN" -p "$PROMPT" --plugin-dir "$RAIZ/plugins/estudio-ia" \
      --setting-sources project,local --strict-mcp-config --model "$MODELO" \
      --no-session-persistence --max-budget-usd "$BUDGET" \
      --output-format stream-json --verbose --tools "$TOOLS" --allowedTools "$TOOLS") \
      > "$d/salida.jsonl" 2> "$d/err.txt"
  jq -r 'select(.type=="result") | .total_cost_usd // 0' "$d/salida.jsonl" 2>/dev/null | tail -1 > "$d/costo.txt"
  [ -s "$d/costo.txt" ] || echo 0 > "$d/costo.txt"
  sub=$(jq -r 'select(.type=="result") | .subtype' "$d/salida.jsonl" 2>/dev/null | tail -1)
  if grep -q 'Failed to authenticate' "$d/salida.jsonl" "$d/err.txt" 2>/dev/null; then
    echo "error: sin autenticación" > "$d/res.txt"
  elif [ "$sub" != success ]; then
    echo "error: la corrida terminó con ${sub:-sin resultado}" > "$d/res.txt"
  else
    sh "$HERE/check.sh" "$caso" "$dir" "$d/salida.jsonl" > "$d/res.txt" 2>&1
  fi
  exit 0
fi

N=${1:-5}; [ $# -gt 0 ] && shift
CASOS=${*:-$(cd "$HERE/casos" && ls *.sh | sed 's/\.sh$//' | tr '\n' ' ')}
OUT=${OUT:-$(mktemp -d /private/tmp/estudio-ia-evals.XXXXXX)}
mkdir -p "$OUT"
for c in $CASOS; do i=1; while [ "$i" -le "$N" ]; do echo "$c $i"; i=$((i + 1)); done; done \
  | REUSAR=$REUSAR OUT=$OUT J=$J LIMITE_USD=$LIMITE_USD MODELO=$MODELO CLAUDE_BIN=$CLAUDE_BIN xargs -P "$J" -L 1 sh "$0" --uno "$OUT" >/dev/null

total=0
{
  echo "# Resultados de evals de estudio-ia"
  echo
  echo "Corrida: $(date '+%Y-%m-%d %H:%M'), cliente: $($CLAUDE_BIN --version 2>/dev/null | head -n 1), modelo: --model $MODELO, $N corridas por caso, umbral 4/5. Salidas completas en \`$OUT\`."
  echo
  echo "## Por caso"
  echo
  echo "| Caso | Skill | Pasa | Costo (USD) | Umbral |"
  echo "|---|---|---|---|---|"
  for c in $CASOS; do
    ok=0; cos=0; n=0
    for r in "$OUT/$c"-*/res.txt; do
      [ -f "$r" ] || continue
      n=$((n + 1)); head -c 4 "$r" | grep -q pass && ok=$((ok + 1))
      cos=$(echo "$cos $(cat "$(dirname "$r")/costo.txt")" | awk '{print $1+$2}')
    done
    total=$(echo "$total $cos" | awk '{print $1+$2}')
    sk=$(sed -n 's/^SKILL=\([a-z-]*\);.*/\1/p' "$HERE/casos/$c.sh" | head -1)
    printf '| %s | %s | %s/%s | %.2f | %s |\n' "$c" "$sk" "$ok" "$n" "$cos" "$([ $((ok * 5)) -ge $((n * 4)) ] && echo cumple || echo 'NO cumple')"
  done
  printf '\n**Costo total: USD %.2f**\n' "$total"
  echo
  echo "## Corridas que no pasaron"
  echo
  echo "| Caso | Corrida | Razón | Extracto de la respuesta |"
  echo "|---|---|---|---|"
  for c in $CASOS; do
    for r in "$OUT/$c"-*/res.txt; do
      [ -f "$r" ] || continue
      head -c 4 "$r" | grep -q pass && continue
      d=$(dirname "$r"); n=${d##*-}
      ex=$(tr '\n|' '  ' < "$d/texto.txt" 2>/dev/null | cut -c1-260)
      printf '| %s | %s | %s | %s |\n' "$c" "$n" "$(tr '\n|' '  ' < "$r")" "$ex"
    done
  done
} > "$RESULTADOS"
cat "$RESULTADOS"
