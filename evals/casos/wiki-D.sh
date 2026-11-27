# Descubrimiento sin slash: pregunta contestable; responde citando la ficha y su fuente real.
SKILL=wiki; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="¿Qué dice mi wiki sobre el gancho de apertura? $NOTA_P"
check() {
  skill_cargada wiki || fail "no se cargó la skill wiki"
  tiene 'gancho-de-apertura|ficha' || fail "no citó la ficha"
  tiene 'RAW/2026-11-20-notas-taller-de-video' || fail "no citó la fuente de la ficha"
  tiene 'cocina' || fail "no usó el ejemplo de la ficha"
  sin_escritura
  pass "cargó wiki y respondió citando la ficha y su fuente"
}
