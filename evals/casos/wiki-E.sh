# Modo sin archivos (claude.ai): no escribe y ofrece wiki.md completo o modo ligero.
SKILL=wiki; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="/estudio-ia:wiki Estoy en claude.ai, no puedes escribir archivos. Agrega esto a mi wiki: \"El plano contrapicado se toma desde abajo hacia arriba y hace que el sujeto se vea más grande o imponente.\" Sin autor ni enlace. $NOTA_P"
check() { modo_sin_archivos; pass "no escribió nada y ofreció wiki.md completo o modo ligero"; }
