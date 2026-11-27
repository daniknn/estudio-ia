# Descubrimiento sin slash: "revísalo antes de publicar" carga revisar y no edita nada.
SKILL=revisar; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="Ya terminé el guion de proyectos/reel-revisar, revísalo antes de publicar. $NOTA_P"
check() {
  skill_cargada revisar || fail "no se cargó la skill revisar"
  sin_escritura
  tiene 'bloquea|conviene|detalle|evidencia' || fail "no entregó hallazgos con severidad o evidencia"
  pass "cargó revisar, entregó hallazgos y no editó archivos"
}
