# Descubrimiento sin slash: "tengo una idea para un corto sobre mi abuela" carga brief y crea el archivo.
SKILL=brief; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="Tengo una idea para un corto sobre mi abuela. Título: La receta de la abuela Chela. Formato: video. Idea: una nieta intenta reconstruir el mole de su abuela sin la receta escrita y lo logra al recordar el olor de la cocina. Público: jóvenes de 18 a 30 años que viven lejos de su familia. Qué debe lograr: que quien lo vea le pida a un familiar mayor una receta o un recuerdo antes de que termine la semana. Fuera de alcance: sin diálogos hablados ni música con derechos. $NOTA_A"
check() {
  skill_cargada brief || fail "no se cargó la skill brief"
  f=$(nuevos | grep -E '^\./proyectos/[^/]+/brief\.md$' | head -1)
  [ -n "$f" ] || fail "no creó proyectos/<slug>/brief.md"
  s=$(echo "$f" | sed 's|^\./proyectos/||; s|/brief.md$||')
  echo "$s" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$' || fail "slug inválido: $s"
  r=$($LIB brief "$dir/$f" --formato video --sin-presupuesto --efecto 'familiar|receta|recuerdo') || fail "$r"
  pass "cargó brief y creó $f con los campos del esquema, sin inventar presupuesto"
}
