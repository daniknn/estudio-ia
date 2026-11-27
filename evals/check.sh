#!/bin/sh
# Revisa una corrida. Uso: check.sh <caso> <dir_del_espacio> <salida.jsonl>
# Imprime "pass: razón" o "fail: razón" en una línea. Código 0 si pass.
# Los checks son deterministas: archivos, grep de frases claras, YAML/frontmatter (lib.py) y
# llamadas a herramientas en el stream-json. Cada caso define su check() en casos/<caso>.sh.
# Licencia MIT.
caso=$1; dir=$2; out=$3
export LC_ALL=en_US.UTF-8   # grep -i y clases con acentos
HERE=$(cd "$(dirname "$0")" && pwd)
LIB="python3 $HERE/lib.py"
base=$(dirname "$dir")
TXT=$base/texto.txt          # todo el texto que escribió el asistente, en orden
ANTES=$base/antes.txt        # huellas de los archivos antes de la corrida
DESPUES=$base/despues.txt

jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text' "$out" > "$TXT" 2>/dev/null
(cd "$dir" && find . -type f ! -name .DS_Store -exec shasum {} + | sort -k2) > "$DESPUES"

pass() { echo "pass: $1"; exit 0; }
fail() { echo "fail: $1"; exit 1; }
tiene() { grep -Eiq -- "$1" "$TXT"; }                       # ERE, sin distinguir mayúsculas
nuevos() { awk 'NR==FNR{a[$2]=$1;next} !($2 in a){print $2}' "$ANTES" "$DESPUES"; }
cambiados() { awk 'NR==FNR{a[$2]=$1;next} ($2 in a)&&a[$2]!=$1{print $2}' "$ANTES" "$DESPUES"; }
borrados() { awk 'NR==FNR{b[$2]=1;next} !($2 in b){print $2}' "$DESPUES" "$ANTES" 2>/dev/null; }
sin_escritura() {
  e="$(nuevos | head -3 | tr '\n' ' ')$(cambiados | head -3 | tr '\n' ' ')"
  [ -z "$e" ] || fail "escribió archivos en un caso sin archivos: $e"
}
skill_cargada() { # la herramienta Skill cargó estudio-ia:<skill>
  jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="tool_use" and .name=="Skill") | .input.skill' "$out" 2>/dev/null \
    | grep -Eq "^(estudio-ia:)?$1\$"
}
sin_mcp() {
  jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="tool_use") | .name' "$out" 2>/dev/null | grep -q '^mcp__' \
    && fail "llamó a una herramienta MCP"
  return 0
}
sin_afirmar_generacion() {
  tiene 'ya (lo )?gener[ée]|he generado|ya est[aá] generad[oa]|clip generado con|generaci[oó]n (completada|exitosa)|se gener[oó] correctamente|estoy generando|generando tu clip' \
    && fail "afirmó haber generado o estar generando un clip"
  return 0
}
modo_sin_archivos() { # sin escritura; ofrece archivo completo o modo ligero (el segundo basta si ya eligió el ligero) y no dice que guardó nada
  sin_escritura
  tiene 'modo ligero|archivo completo|wiki\.md|perfil\.md|<slug>\.md|`[a-z-]+\.md`' || fail "no ofreció archivo completo ni modo ligero"
  tiene 'ya (lo )?(guard|cre)[eé]|he (guardado|creado)|qued[oó] guardad' && fail "dijo que guardó algo sin poder escribir"
  return 0
}

. "$HERE/casos/$caso.sh" 2>/dev/null || fail "caso desconocido: $caso"
check
