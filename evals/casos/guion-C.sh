# Modo sin archivos (claude.ai): no escribe y ofrece archivo completo o modo ligero.
SKILL=guion; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="/estudio-ia:guion Estoy en claude.ai, no puedes escribir archivos. Quiero el guion de un anuncio de 30 segundos para una panadería de barrio que hace pan de muerto. Público: familias de la colonia. Quiero que pasen a apartar su pan. $NOTA_P"
check() { modo_sin_archivos; pass "no escribió nada y ofreció archivo completo o modo ligero"; }
