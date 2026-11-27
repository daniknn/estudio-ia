# Slash: escribe articulo.md desde el brief (formato articulo); cita solo wiki/RAW y no inventa URLs ni cifras.
SKILL=articulo; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:articulo proyectos/articulo-tercios. Unas 500 palabras. Fuentes: solo las de mi wiki (fichas y RAW); no agregues datos, cifras, citas ni enlaces que no estén ahí. Guárdalo en proyectos/articulo-tercios/articulo.md. $NOTA_A"
check() {
  f=$dir/proyectos/articulo-tercios/articulo.md
  [ -f "$f" ] || fail "no escribió proyectos/articulo-tercios/articulo.md"
  r=$(python3 -I - "$f" "$dir" "$dir/proyectos/articulo-tercios/brief.md" "$PROMPT" <<'PY'
import os, re, sys
f, d, brief, prompt = sys.argv[1:5]
t = open(f, encoding="utf-8").read()
url = lambda s: {u.rstrip(".,;:)*_") for u in re.findall(r"https?://[^\s)>\]]+", s)}
extra = url(t) - url(open(brief, encoding="utf-8").read() + prompt)
if extra: print("URL que no está en el brief ni en el prompt: %s" % sorted(extra)[0]); sys.exit()
if not t.lstrip().startswith("# "): print("no empieza con # Titular"); sys.exit()
cuerpo = re.split(r"^## (?:Por verificar|Fuentes)\b", t, flags=re.M)[0]
n = len(re.findall(r"\w+", cuerpo))
if not 250 <= n <= 750: print("extensión %d palabras, se pedían unas 500" % n); sys.exit()
if len(re.findall(r"^## ", cuerpo, re.M)) < 2: print("menos de 2 secciones ## en el cuerpo"); sys.exit()
if not re.search(r"^## Fuentes", t, re.M): print("sin ## Fuentes"); sys.exit()
fu = t.split("## Fuentes", 1)[1]
if not re.search(r"wiki/|RAW|regla-de-los-tercios|gancho", fu): print("## Fuentes no cita fichas ni RAW"); sys.exit()
for p in set(re.findall(r"wiki/[\w/.-]+\.md", t)):
    if not os.path.exists(os.path.join(d, p)): print("cita un archivo que no existe: %s" % p); sys.exit()
for l in cuerpo.split("\n"):
    if re.search(r"\d+([.,]\d+)? ?(%|por ciento|millones)", l) and "[sin verificar]" not in l:
        print("cifra sin fuente ni marca: %s" % l.strip()[:90]); sys.exit()
print("ok")
PY
)
  [ "$r" = ok ] || fail "$r"
  cambiados | grep -q 'RAW/' && fail "editó un archivo de RAW/"
  pass "articulo.md con titular, secciones, extensión cercana, Fuentes de wiki/RAW, sin URLs ni cifras inventadas"
}
