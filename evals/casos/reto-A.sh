# Slash: lanza un subagente con un modelo distinto, presenta hallazgos con evidencia y no edita archivos.
SKILL=reto-en-frio; FIXTURE=espacio; BUDGET=3; TOOLS="Bash,Write,Edit,Read,Skill,Agent"
setup() { :; }
PROMPT="/estudio-ia:reto-en-frio Quiero el reto en frío de proyectos/corto-abuela antes de entregar. Todavía no hay shotlist: sigue solo con el brief y el guion, no preguntes por eso. $NOTA_P"
check() {
  sin_escritura
  jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="tool_use") | "\(.name) \(.input.model // "")"' "$out" | grep -Eq '^(Agent|Task) (opus|haiku|fable)$' \
    || fail "no lanzó un subagente con un modelo distinto de sonnet (parámetro model)"
  for h in H1 H2 H3; do tiene "$h" || fail "faltan hallazgos (no aparece $h)"; done
  tiene 'guion\.md|brief\.md|ESC [0-9]' || fail "los hallazgos no citan evidencia"
  tiene 'revis[oó][^.]{0,40}(opus|haiku|fable)|modelo que revis|(opus|fable)' || fail "no nombró el modelo revisor"
  tiene 'incorporas o (lo )?rechazas|lo incorporas' || fail "no pidió la decisión de H1"
  pass "subagente con model distinto, 3 o más hallazgos con evidencia, nombra al revisor, pide decidir H1 y no tocó archivos"
}
