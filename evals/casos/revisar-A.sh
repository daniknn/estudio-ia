# Slash sobre una pieza con una cifra sin fuente y una canción de terceros sin crédito: señala ambas con evidencia y no edita.
SKILL=revisar; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:revisar proyectos/reel-revisar. Revisa el guion.md antes de publicar. No tengo más información: lo que no sepas márcalo como no verificado. $NOTA_P"
check() {
  sin_escritura
  tiene '87' || fail "no señaló la cifra del 87 %"
  tiene 'wonderwall|oasis' || fail "no señaló la canción de terceros"
  tiene 'sin (fuente|verificar)|no (tiene|cita|hay|trae|indica|dice)[^.]{0,40}(fuente|origen)|fuente|verific' || fail "no dijo que la cifra carece de fuente"
  tiene 'cr[eé]dito|licencia|derechos' || fail "no habló de crédito, licencia o derechos de la canción"
  tiene 'evidencia' || fail "los hallazgos no traen evidencia"
  pass "señaló la cifra sin fuente y la canción sin crédito con evidencia; no editó archivos"
}
