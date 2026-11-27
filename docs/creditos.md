# Créditos: tu tope y cómo bajar el costo

Cada clip que generas en Higgsfield gasta créditos, y no se reembolsan. Por eso el tope se cuida antes de generar, no después.

## Presupuesto por proyecto

En tu brief puedes fijar `presupuesto_creditos`, y en tu perfil un `tope_creditos_mes`. Son opcionales, pero te protegen: sabes cuánto cuesta una pieza antes de empezar y evitas sorpresas a fin de mes.

Cada archivo de `prompts/` guarda el `costo_creditos` real de su clip (el que te mostró Higgsfield; si no hay otro dato, la cotización). Suma también las versiones viejas (`-v1`, `-v2`): un clip regenerado ya gastó sus créditos.

## Cotiza antes de generar

La skill `prompt-video` lo hace contigo, y el plugin lo exige:

1. Mira tu saldo en Higgsfield.
2. Pide la cotización del clip (Higgsfield dice cuánto costaría, sin generar nada).
3. Compárala con lo que te queda: tu presupuesto menos lo ya gastado en `prompts/`.
4. Genera solo si te alcanza y respondes "sí" tú mismo, un plano a la vez.

En claude.ai no hay un freno automático, pero la regla es la misma: sin cotización y sin tu "sí", no se genera.

## Cómo bajar el costo de un clip

- Menos duración: ¿de verdad necesitas 8 s o alcanzan 5? Confirma el efecto en la cotización de tu cuenta.
- Menos resolución: prueba en 720p antes de pedir más, y compara las cotizaciones.
- Un modo más barato, si tu modelo lo tiene. Ejemplo de una cotización real (5 s, 720p, sin audio, 16:9): `seedance_2_0` costó 22.5 créditos en modo std y 12.5 en modo fast. Los precios cambian: usa siempre la cotización de tu cuenta.
- Sin audio, si el sonido lo vas a hacer aparte.
- Menos intentos: afina el prompt en texto antes de generar y quita los planos que no sirvan a lo que la pieza debe lograr.

Si aun así necesitas pasarte de tu tope, decide tú: sube el número en tu brief con conciencia de lo que gastas.
