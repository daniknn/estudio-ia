# Slash: escaleta.md con Duración estimada en la primera línea, bloques con solo hora de inicio y diseño sonoro.
SKILL=podcast; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:podcast proyectos/podcast-oficios. Episodio narrado a una voz de unos 8 minutos. No tengo música ni efectos elegidos ni sé su licencia: lo que falte márcalo como hueco. Guárdalo en proyectos/podcast-oficios/escaleta.md. $NOTA_A"
check() {
  f=$dir/proyectos/podcast-oficios/escaleta.md
  [ -f "$f" ] || fail "no escribió proyectos/podcast-oficios/escaleta.md"
  head -n 1 "$f" | grep -Eq '^Duración estimada:' || fail "la primera línea no es 'Duración estimada:': $(head -n 1 "$f" | cut -c1-60)"
  grep -Eq '^## \[[0-9]+:[0-9]{2}[^]]*[–—-][^]]*\]' "$f" && fail "algún bloque usa rango de tiempo en el encabezado"
  grep -Eq '^## Diseño sonoro' "$f" || fail "sin ## Diseño sonoro"
  r=$(python3 -I - "$f" <<'PY'
import re, sys
t = open(sys.argv[1], encoding="utf-8").read()
m = re.match(r"Duración estimada:?\W*(\d+):(\d{2})", t)
if not m: print("la duración no empieza con mm:ss"); sys.exit()
dur = int(m.group(1)) * 60 + int(m.group(2))
b = re.findall(r"^## \[(\d+):(\d{2})\] (.+)$", t, re.M)
if len(b) < 4: print("hay %d bloques '## [mm:ss] Bloque · propósito' (se esperan 4 o más)" % len(b)); sys.exit()
ts = [int(x) * 60 + int(y) for x, y, _ in b]
if ts[0] != 0: print("el primer bloque no empieza en 00:00"); sys.exit()
if ts != sorted(ts) or len(set(ts)) != len(ts): print("tiempos no crecientes: %s" % ts); sys.exit()
if ts[-1] >= dur: print("el último bloque (%ds) empieza fuera de la duración (%ds)" % (ts[-1], dur)); sys.exit()
if not 420 <= dur <= 540: print("duración %ds, se pedían unos 8 min" % dur); sys.exit()
if not re.search(r"gancho|hook", b[0][2], re.I): print("el primer bloque no es el gancho: %s" % b[0][2]); sys.exit()
for _, _, x in b:
    if not re.search(r"[·—–]| - ", x): print("bloque sin propósito: %s" % x); sys.exit()
print("ok")
PY
)
  [ "$r" = ok ] || fail "$r"
  pass "escaleta.md con Duración estimada primero, bloques con solo hora de inicio, gancho y diseño sonoro"
}
