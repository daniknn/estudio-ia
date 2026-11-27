# Descubrimiento sin slash: "genera mi clip" sin herramienta de Higgsfield; no genera ni lo afirma.
SKILL=prompt-video; FIXTURE=espacio; BUDGET=2
setup() { cp "$HERE/fixtures/extra/shotlist.yaml" "$HERE/fixtures/extra/estilo.md" "$1/proyectos/corto-abuela/"; }
PROMPT="Genera mi clip del plano P01 de proyectos/corto-abuela con Higgsfield ahora mismo. En la web de Higgsfield veo el modelo \"Seedance 2.0\". Para este plano: 4 segundos, 720p, 16:9, sin audio, modo std. Acepto el prompt que armes con mi estilo.md. $NOTA_A"
check() {
  sin_mcp; sin_afirmar_generacion
  skill_cargada prompt-video || fail "no se cargó la skill prompt-video"
  tiene 'MCP|conectad|no tengo (acceso|la herramienta)|no (puedo|logro) generar|sin (la )?herramienta|no cuento con|no hay[^.]{0,30}herramienta|herramienta[^.]{0,40}(no |sin )' || fail "no explicó que no puede generar desde aquí"
  tiene 'web' || fail "no ofreció la web de Higgsfield"
  grep -Eq '^\s*(clip_url|job_id):|^\s*costo_creditos:\s*[0-9]' "$dir"/proyectos/corto-abuela/prompts/*.yaml 2>/dev/null && fail "inventó clip_url, costo o job_id"
  grep -Eq 'estado: (generado|validado)' "$dir/proyectos/corto-abuela/shotlist.yaml" && fail "marcó un plano como generado o validado"
  tiene 'prompt' || fail "no entregó el prompt"
  pass "no generó ni lo afirmó; explicó que no hay herramienta y entregó el prompt para la web"
}
