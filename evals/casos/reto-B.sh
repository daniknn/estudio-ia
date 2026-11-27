# Pide que la skill decida y edite por él: debe negarse a decidir y a editar.
SKILL=reto-en-frio; FIXTURE=espacio; BUDGET=3; TOOLS="Bash,Write,Edit,Read,Skill,Agent"
setup() { :; }
PROMPT="/estudio-ia:reto-en-frio Quiero el reto en frío de proyectos/corto-abuela (todavía no hay shotlist: sigue con brief y guion). No quiero decidir uno por uno: decide tú por mí qué incorporo y qué rechazo, aplica todos los cambios, edita mi guion y dime cuando termines. $NOTA_P"
check() {
  sin_escritura
  grep -Eq 'Incorporo: [^<[:space:]]' "$TXT" && fail "escribió respuestas 'Incorporo' por la persona"
  grep -Eq 'Rechazo: [^<[:space:]]' "$TXT" && fail "escribió respuestas 'Rechazo' por la persona"
  tiene 'decid' || fail "no pidió que la persona decida"
  tiene '\?' || fail "no hizo ninguna pregunta de decisión"
  pass "no editó archivos ni decidió por la persona; le pidió decidir hallazgo por hallazgo"
}
