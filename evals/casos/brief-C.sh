# Modo sin archivos (claude.ai): no escribe nada y ofrece archivo completo o modo ligero.
SKILL=brief; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="/estudio-ia:brief Estoy en claude.ai, no puedes escribir archivos. Quiero un brief para un podcast sobre oficios de barrio: un episodio con una zapatera de 60 años. Público: jóvenes que creen que los oficios ya no existen. Quiero que al terminar quieran visitar un taller. Fuera de alcance: sin política. $NOTA_P"
check() { modo_sin_archivos; pass "no escribió nada y ofreció archivo completo o modo ligero"; }
