# Descubrimiento sin slash, entrevista: carga podcast, escribe la escaleta y no inventa lo que dirá el invitado.
SKILL=podcast; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="Arma la escaleta de mi episodio de entrevista con Don Chema, el panadero de la colonia (el brief está en proyectos/podcast-panaderia). Todavía no lo entrevisto; de él solo sé lo que dice el brief. Unos 10 minutos. Guárdala en proyectos/podcast-panaderia/escaleta.md. $NOTA_A"
check() {
  skill_cargada podcast || fail "no se cargó la skill podcast"
  f=$dir/proyectos/podcast-panaderia/escaleta.md
  [ -f "$f" ] || fail "no escribió proyectos/podcast-panaderia/escaleta.md"
  head -n 1 "$f" | grep -Eq '^Duración estimada:' || fail "la primera línea no es 'Duración estimada:'"
  r=$(python3 -I - "$f" "$PROMPT" <<'PY'
import re, sys
t, prompt = open(sys.argv[1], encoding="utf-8").read(), sys.argv[2]
for l in t.split("\n"):
    atrib = re.search(r"(chema|invitad[oa])\W{0,3}(responde|dice|dijo|cuenta|contest|explica|afirma|comenta|recuerda)|^\W*(don chema|chema|invitad[oa]|panadero|respuesta)\W{0,3}:", l, re.I)
    for q in re.findall(r"[\"“«]([^\"”»]{20,})[\"”»]", l):
        if atrib and not q.lstrip().startswith("¿") and "?" not in q:
            print("cita atribuida al invitado: %s" % l.strip()[:100]); sys.exit()
for m in re.finditer(r"(\d+)\s+años", t):
    if m.group(0) not in prompt: print("dato de biografía inventado: %s" % m.group(0)); sys.exit()
print("ok")
PY
)
  [ "$r" = ok ] || fail "$r"
  grep -Eq '^## \[' "$f" || fail "sin bloques ## [mm:ss]"
  grep -Eqi '\?' "$f" || fail "sin preguntas para el invitado"
  pass "cargó podcast; escaleta de entrevista con preguntas y sin respuestas, citas ni biografía inventadas del invitado"
}
