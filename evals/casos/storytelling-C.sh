# Descubrimiento sin slash: "qué estructura me conviene" carga storytelling y recomienda periodismo de servicio.
SKILL=storytelling; FIXTURE=espacio; BUDGET=1
setup() { :; }
PROMPT="No sé cómo estructurar mi reportaje para el podcast: un vecino de la colonia se queja de que el ayuntamiento nunca arregló la bomba de agua; tengo audios del afectado, fotos del tanque seco y la respuesta por escrito del ayuntamiento. ¿Qué estructura me conviene? Quiero que quien lo escuche presione al ayuntamiento. $NOTA_P"
check() {
  skill_cargada storytelling || fail "no se cargó la skill storytelling"
  tiene 'periodismo de servicio|nota de TV' || fail "no recomendó periodismo de servicio ni nota de TV"
  sin_escritura
  pass "cargó storytelling y recomendó una estructura de reportaje con afectado y pruebas"
}
