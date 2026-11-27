# La persona no da lecciones: no inventa y no escribe nada.
SKILL=aprendizaje; FIXTURE=espacio; BUDGET=1
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:aprendizaje Cierro proyectos/reel-previo, pero la verdad no sé qué aprendí; no tengo nada que decir sobre qué funcionó o no. Hoy es 2026-11-26. $NOTA_A"
check() {
  sin_escritura
  tiene 'nada (que|para) (anotar|escribir|guardar)|no (voy a )?(escrib|anot|guard|invent)|sin (nada|lecciones)|cuando quieras|vuelve' || fail "no dijo que no hay nada que anotar"
  tiene 'ya (lo )?(anot|guard|agreg)[eé]|he (anotado|guardado|agregado)|qued[oó] (guardad|anotad)' && fail "dijo que guardó algo sin lecciones"
  pass "no escribió nada, dijo que no hay nada que anotar"
}
