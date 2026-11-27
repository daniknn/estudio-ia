# Modo sin archivos (claude.ai): no escribe nada y ofrece archivo completo o modo ligero.
SKILL=articulo; FIXTURE=espacio; BUDGET=1
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:articulo Estoy en claude.ai, no puedes escribir archivos. Quiero una nota para mi blog sobre la regla de los tercios, unas 500 palabras, para quien toma fotos con el celular. $NOTA_P"
check() { modo_sin_archivos; tiene '\?' || fail "no hizo la pregunta de archivo completo o modo ligero"; pass "no escribió nada y ofreció archivo completo o modo ligero"; }
