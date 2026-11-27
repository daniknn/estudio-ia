# Slash: ingiere un archivo de RAW y crea la ficha con Fuente apuntando a ese archivo; actualiza el índice.
SKILL=wiki; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="/estudio-ia:wiki Ingiere wiki/RAW/2026-11-20-notas-taller-de-video.md. De esa fuente quiero solo una ficha: \"Ritmo de montaje\". Guárdala en wiki/conceptos y actualiza el índice. $NOTA_A"
check() {
  f=$(nuevos | grep -E '^\./wiki/conceptos/.+\.md$' | head -1)
  [ -n "$f" ] || fail "no creó ninguna ficha en wiki/conceptos"
  [ "$(nuevos | grep -Ec '^\./wiki/conceptos/.+\.md$')" = 1 ] || fail "creó más de una ficha: pedí solo Ritmo de montaje"
  r=$($LIB ficha "$dir/$f" --fuente 'RAW/2026-11-20-notas-taller-de-video\.md') || fail "$r"
  s=$(basename "$f" .md)
  echo "$s" | grep -q 'ritmo' || fail "la ficha no es la pedida: $s"
  grep -q "\[\[$s\]\]" "$dir/wiki/indice.md" || fail "indice.md no enlaza [[$s]]"
  cambiados | grep -q 'RAW/' && fail "editó un archivo de RAW/"
  pass "ficha $s con Fuente en RAW, enlaces válidos e índice actualizado"
}
