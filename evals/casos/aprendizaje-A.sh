# Slash con lecciones dadas: agrega una entrada fechada al final de aprendizajes.md sin quitar lo anterior.
SKILL=aprendizaje; FIXTURE=espacio; BUDGET=1.5
setup() { cp -R "$HERE/fixtures/extra/v02/proyectos/." "$1/proyectos/"; }
PROMPT="/estudio-ia:aprendizaje Cierro proyectos/reel-previo. Hoy es 2026-11-26. Resultado: lo publiqué y lo vieron 120 personas. Qué funcionó: grabar con luz de ventana por la mañana. Qué no funcionó: el subtítulo automático se equivocó con los nombres propios. Qué repetiría: revisar los subtítulos uno por uno antes de publicar. Guarda la entrada en proyectos/reel-previo/aprendizajes.md. $NOTA_A"
check() {
  f=$dir/proyectos/reel-previo/aprendizajes.md
  [ -f "$f" ] || fail "no existe aprendizajes.md"
  cambiados | grep -q 'aprendizajes\.md' || fail "no modificó aprendizajes.md"
  r=$(python3 -I - "$f" "$HERE/fixtures/extra/v02/proyectos/reel-previo/aprendizajes.md" <<'PY'
import re, sys
t = open(sys.argv[1], encoding="utf-8").read()
v = open(sys.argv[2], encoding="utf-8").read().rstrip()
if not t.startswith(v): print("las entradas anteriores no quedaron intactas al inicio del archivo"); sys.exit()
nuevo = t[len(v):]
if not re.search(r"^## 2026-11-26\b", nuevo, re.M): print("sin encabezado '## 2026-11-26 · ...' en la entrada nueva"); sys.exit()
for k in ("luz de ventana", "subtítulo", "uno por uno"):
    if k not in nuevo: print("la entrada no conserva lo que dijo la persona: %s" % k); sys.exit()
print("ok")
PY
)
  [ "$r" = ok ] || fail "$r"
  cambiados | grep -qE 'RAW/|brief\.md' && fail "editó RAW o un brief"
  for n in $(nuevos | grep -E '^\./wiki/conceptos/.+\.md$'); do
    grep -q '^Fuente: aprendizajes de reel-previo, 2026-11-26' "$dir/$n" || fail "ficha nueva $n sin la Fuente de aprendizajes"
    head -n 1 "$dir/$n" | grep -q '^---' && fail "ficha nueva $n con frontmatter"
  done
  pass "entrada fechada agregada al final de aprendizajes.md con las palabras de la persona, lo anterior intacto"
}
