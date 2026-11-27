# Higgsfield: hechos verificados para prompt-video

Esta referencia solo aplica si existe una herramienta de Higgsfield. Si no existe, el usuario genera en la web y tú entregas el prompt y los parámetros para pegar.

## Cómo reconocer las herramientas

- El nombre del servidor cambia por cuenta (a veces es un código largo). Por eso se buscan por el **final** del nombre: `balance`, `models_explore` y `generate_video`.
- Si aparecen como herramientas diferidas, cárgalas con la herramienta de búsqueda de herramientas antes de usarlas.
- Si no hay ninguna que termine en `balance` o `generate_video`, trabaja sin ellas.

## Qué hace cada una

| Herramienta | Uso en esta skill |
|---|---|
| `balance` | Saldo de la cuenta. Muéstralo tal como lo devuelve. |
| `models_explore` | Lista los modelos reales (acción `list`, `type: video`) y da los límites de uno (acción `get`): duración, modos, resoluciones. El ID que escribes en el archivo es el que devuelve esta herramienta, no uno que recuerdes. |
| `generate_video` | Genera. Con `params.get_cost: true` **solo cotiza**: devuelve el costo en créditos (`cost.credits`) y no envía nada. Sin `get_cost`, o con `false`, gasta créditos. |

Cotizar es la única forma de saber el costo antes de generar. Una cotización vale para los mismos `params`; si cambias duración, resolución, modo o audio, cotiza de nuevo.

## Precios de referencia (sugerencias, no hechos)

Cifras observadas con Seedance 2.0. Úsalas para orientar la conversación y márcalas siempre como sugerencia. Si la cotización real dice otra cosa, manda la cotización.

- Seedance 2.0 Mini a 720p: cerca de 1 crédito por segundo.
- Seedance 2.0 fast a 720p: cerca de 2.5 créditos por segundo.
- Seedance 2.0 fast a 480p: cerca de 1 crédito por segundo.

Cuentas rápidas (también sugerencias): con un presupuesto de 80 créditos, a 1 por segundo caben unos 80 s en total, o unos 40 s si quieres margen para un reintento por plano. A 2.5 por segundo alcanzan unos 32 s sin reintentos.

## Orden obligatorio antes de gastar

1. `balance`.
2. `generate_video` con los mismos `params` y `get_cost: true`.
3. Comparar el costo contra lo que queda del presupuesto.
4. Un "sí" literal del usuario para ese plano.
5. `generate_video` sin `get_cost`.

Un plano a la vez. Nunca uses variantes `_batch` ni generes varios planos con un solo "sí". Lo mismo aplica a otras herramientas que gastan créditos (upscale, presets, reframe, voz): primero saldo y cotización cuando la herramienta la acepte, luego el "sí".

## Qué guardar

- `job_id`: solo si Higgsfield lo devolvió. Si no devolvió uno, no lo escribas.
- `costo_creditos`: el costo que reportó Higgsfield o, si no reportó otro, la cotización. Nunca un número estimado por ti.
- Si el resultado no trae el clip listo, dile al usuario que lo vea en su cuenta de Higgsfield. No inventes ni completes links de clips.
