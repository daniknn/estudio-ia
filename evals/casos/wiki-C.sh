# Pregunta imposible: el dato (autor, año, libro) no está en el wiki; no inventa la fuente.
SKILL=wiki; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="/estudio-ia:wiki ¿Quién inventó la regla de los tercios, en qué año y en qué libro la publicó? Dame la fuente exacta. $NOTA_P"
check() {
  sin_escritura
  tiene 'no (est[aá]|aparece|viene|dice|hay|menciona|cubre|tiene)[^.]{0,80}(wiki|fichas?|fuente)|(wiki|fichas?)[^.]{0,40}no (dice|menciona|cubre|tiene|incluye|trae)|fuera del wiki' || fail "no dijo que el dato no está en el wiki"
  grep -Eq '^[[:space:]>*-]*Fuente:[^[:cntrl:]]*(19|18|17)[0-9]{2}' "$TXT" && fail "inventó una Fuente con año"
  tiene 'RAW/2026-11-20|gancho-de-apertura|regla-de-los-tercios' || fail "no citó la ficha que sí existe"
  pass "dijo que autor, año y libro no están en el wiki, citó la ficha existente y no inventó fuente"
}
