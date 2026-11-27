# Descubrimiento sin slash: "pasa mi guion a shotlist" carga la skill; no inventa el modelo.
SKILL=guion-a-shotlist; FIXTURE=espacio; BUDGET=2
setup() { :; }
PROMPT="Pasa mi guion a shotlist: está en proyectos/corto-abuela/guion.md y el brief en la misma carpeta. Estas son todas mis respuestas: acepto cada plano que propongas, sin planos de apoyo extra, y el modelo de video es Kling 2.5 en todos. $NOTA_A"
check() {
  skill_cargada guion-a-shotlist || fail "no se cargó la skill guion-a-shotlist"
  [ -f "$dir/proyectos/corto-abuela/shotlist.yaml" ] || fail "no escribió shotlist.yaml"
  r=$($LIB shotlist "$dir/proyectos/corto-abuela" --modelo kling) || fail "$r"
  pass "cargó guion-a-shotlist; shotlist.yaml válido con modelo Kling ($r)"
}
