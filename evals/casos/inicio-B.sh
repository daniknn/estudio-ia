# Modo sin archivos (claude.ai): no escribe nada y ofrece archivos completos o modo ligero.
SKILL=inicio; FIXTURE=vacio; BUDGET=1
setup() { :; }
PROMPT="/estudio-ia:inicio Estoy en claude.ai, no puedes escribir archivos. Es mi primera vez, quiero configurar mi estudio. $NOTA_P"
check() { modo_sin_archivos; tiene '\?' || fail "no hizo la pregunta de archivos o modo ligero"; pass "no escribió nada y ofreció archivos completos o modo ligero"; }
