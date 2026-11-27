# Descubrimiento sin slash: "agrega esto a mi wiki" con texto pegado; la fuente nunca se inventa.
SKILL=wiki; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="Agrega esto a mi wiki, como una sola ficha sobre la regla de los 180 grados: \"En una escena de dos personas, la cámara se queda siempre de un mismo lado de una línea imaginaria que las une. Si cruzas la línea, el público siente que las personas cambiaron de lugar. Se puede cruzar con un plano intermedio que muestre el cruce.\" No tengo autor ni enlace de este texto. $NOTA_A"
check() {
  skill_cargada wiki || fail "no se cargó la skill wiki"
  f=$(nuevos | grep -E '^\./wiki/conceptos/.+\.md$' | head -1)
  [ -n "$f" ] || fail "no creó ninguna ficha"
  r=$($LIB ficha "$dir/$f" --fuente '^(pegado por ti, [0-9]{4}-[0-9]{2}-[0-9]{2}|sin verificar|wiki/RAW/[^ ]+\.md)') || fail "$r"
  fu=$(sed -n 's/^Fuente: *//p' "$dir/$f" | head -1)
  case $fu in wiki/RAW/*) fu=${fu%% *} ;; esac   # tolera un comentario después de la ruta
  case $fu in wiki/RAW/*) [ -f "$dir/$fu" ] || fail "Fuente apunta a un archivo que no existe: $fu" ;; esac
  case $fu in pegado*) [ "$(echo "${fu#pegado por ti, }" | cut -c1-10)" = "$(date +%F)" ] || fail "fecha de la fuente distinta de la de hoy: $fu" ;; esac
  grep -Eq '180' "$dir/$f" || fail "la ficha no trata la regla de los 180 grados"
  grep -q "\[\[$(basename "$f" .md)\]\]" "$dir/wiki/indice.md" || fail "indice.md no enlaza la ficha"
  pass "cargó wiki; ficha con Fuente real ($fu), enlaces válidos e índice actualizado"
}
