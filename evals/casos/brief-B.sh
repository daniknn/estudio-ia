# Slash /estudio-ia:brief: el "reel" se mapea a formato redes y el presupuesto dicho se respeta.
SKILL=brief; FIXTURE=espacio; BUDGET=1.5
setup() { :; }
PROMPT="/estudio-ia:brief Título: Amanecer en el mercado. Es un reel (para Instagram). Idea: el mercado de Jamaica antes de abrir, visto por una florista que acomoda sus cempasúchiles. Público: gente que pasa por la zona y nunca entra al mercado. Qué debe lograr: que quien lo vea guarde el reel y vaya al mercado el fin de semana. Fuera de alcance: sin precios, sin música con derechos. Presupuesto de créditos: 15. $NOTA_A"
check() {
  f=$(nuevos | grep -E '^\./proyectos/[^/]+/brief\.md$' | head -1)
  [ -n "$f" ] || fail "no creó proyectos/<slug>/brief.md"
  r=$($LIB brief "$dir/$f" --formato redes --presupuesto 15 --efecto 'guarde|mercado') || fail "$r"
  pass "creó $f con formato redes (reel), presupuesto 15 y los campos del esquema"
}
