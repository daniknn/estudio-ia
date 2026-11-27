# Descubrimiento sin slash: "es mi primera vez" carga inicio y crea el perfil.
SKILL=inicio; FIXTURE=vacio; BUDGET=1.5
setup() { :; }
PROMPT="Es mi primera vez, quiero configurar mi estudio de contenidos. Me llamo Lupe, soy ilustradora y hago artículos y podcast sobre cocina oaxaqueña. Mi público: gente de 30 a 50 años que quiere cocinar en casa. Temas: cocina oaxaqueña, mercados, recetas de abuela. Formatos: artículo, podcast. Voz: cálida, precisa, paciente. Herramientas: Canva, Audacity. No tengo tope de créditos. Crea mi perfil. $NOTA_A"
check() {
  skill_cargada inicio || fail "no se cargó la skill inicio"
  [ -f "$dir/perfil.md" ] || fail "no creó perfil.md"
  [ -d "$dir/wiki/RAW" ] && [ -f "$dir/wiki/indice.md" ] || fail "no creó la estructura del wiki"
  grep -q 'tope_creditos_mes' "$dir/perfil.md" && fail "inventó tope_creditos_mes"
  grep -Eqi '^nombre:.*Lupe' "$dir/perfil.md" || fail "perfil.md sin el nombre dicho"
  grep -Eq '<.+>' "$dir/perfil.md" && fail "perfil.md con marcadores sin llenar"
  pass "cargó inicio, creó perfil.md sin inventar tope y la estructura del wiki"
}
