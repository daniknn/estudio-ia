# Descubrimiento sin slash: "escríbeme una nota para mi blog" carga articulo y escribe articulo.md.
SKILL=articulo; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="Escríbeme una nota para mi blog sobre cómo usar la regla de los tercios al tomar fotos con el celular; el brief está en proyectos/articulo-tercios. Usa solo lo de mi wiki, sin cifras ni enlaces nuevos. Guárdala en proyectos/articulo-tercios/articulo.md. $NOTA_A"
check() {
  skill_cargada articulo || fail "no se cargó la skill articulo"
  f=$dir/proyectos/articulo-tercios/articulo.md
  [ -f "$f" ] || fail "no escribió proyectos/articulo-tercios/articulo.md"
  grep -Eq '^# \S' "$f" || fail "articulo.md sin titular"
  grep -Eq '^## ' "$f" || fail "articulo.md sin secciones"
  grep -Eqi 'regla de los tercios' "$f" || fail "el artículo no trata el tema pedido"
  pass "cargó articulo; articulo.md con titular y secciones"
}
