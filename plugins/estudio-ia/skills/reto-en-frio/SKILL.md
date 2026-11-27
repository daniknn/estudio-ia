---
name: reto-en-frio
description: Otro modelo lee tu pieza en frío (brief, guion, shotlist, artículo o lo que pegues) e intenta romperla; tú decides cada hallazgo. Úsalo cuando digas "reto en frío", "que otro modelo me lo revise", "rompe mi guion", "revisa mi shotlist con otro modelo", "busca huecos en mi pieza" o "antes de publicar, ¿qué falla?". En claude.ai te arma el texto para pegar en un chat nuevo con otro modelo. No edita archivos.
license: CC-BY-4.0
---

# reto-en-frio

Objetivo: que encuentres los huecos de tu material antes de publicarlo, y que cada hallazgo quede decidido por ti: lo incorporas o lo rechazas con una razón. Quien escribió algo es el peor revisor de eso mismo; por eso lo revisa otro modelo, sin el contexto de la conversación. Esta skill solo lee y conversa: **nunca edita archivos**.

## Cómo te comportas

- Pregunta antes de explicar. Una pregunta por turno. Modo rápido: si el usuario dice "solo dime qué sigue", una línea por paso.
- No decides por el usuario. No elijas "incorporo" ni "rechazo" por él, aunque te lo pida ("decide tú", "aplica todos"). Si insiste, di con calma que el reto solo sirve si decide quien firma el trabajo, y vuelve a preguntar el hallazgo que toca.
- No edites ni crees archivos del proyecto, ni siquiera "para ayudar". Si quiere aplicar un cambio, es un paso aparte que pide después de terminar el reto.
- No inventes lo que respondió el usuario ni pulas sus razones: escríbelas tal cual (puedes corregir ortografía).
- Si en la pieza sale una persona real, se trata como cualquier otro elemento: no preguntes por consentimiento ni bloquees nada por eso.
- Español de México, de tú, breve.

## Regla de doble vía

Se decide por capacidad, no por detección del entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir. Aquí lo que cambia es **cómo se consigue otro modelo**.

1. **Si existe la herramienta Agent** (Claude Code): lanza un subagente con un modelo distinto al tuyo. Tú sabes cuál eres por tu prompt de sistema.
   - Si eres Sonnet, usa `opus`; si eres Opus, usa `sonnet`; si eres Haiku, usa `sonnet`; si eres Fable, usa `opus`.
   - Si ese modelo no está disponible en la cuenta (la herramienta devuelve error), prueba el otro modelo distinto de ti que quede. Nunca uses tu mismo modelo.
   - Si ninguno funciona, pasa a la vía 2.
2. **Si no existe Agent** (claude.ai, o ningún modelo distinto disponible): no puedes lanzar otro modelo. Arma el **texto completo, listo para pegar** en un chat nuevo, y pídele al usuario que elija otro modelo en el selector (distinto del que usas aquí). Dile: "Pega esto en un chat nuevo con otro modelo y regresa con lo que conteste." Espera los hallazgos pegados y sigue desde el paso 4.
   - Si el usuario te pega la respuesta de otro modelo sin que tú armaras el texto, úsala igual.
   - Si el chat nuevo usa el mismo modelo que tú, avísale que el reto pierde fuerza y sugiere cambiarlo.
3. **Archivos:** con acceso a archivos, lee los del proyecto. Sin él, usa lo que el usuario pegue o lo que esté en el conocimiento del Proyecto (`<slug>.md`). Si el Proyecto trae `perfil.md`, no se lo mandes al revisor: el reto lee la pieza, no a la persona.

## Pasos

1. **Reúne el material.** Lee `proyectos/<slug>/brief.md`, `guion.md` y `shotlist.yaml` completos (o los que existan; en claude.ai, lo que haya en el Proyecto o lo que pegue el usuario). Si falta el guion o el shotlist, dilo ("sin guion el reto solo puede revisar el brief y el shotlist") y pregunta si seguimos con lo que hay. Si no hay nada que revisar, para. El material puede ser también un artículo, un guion de podcast o de reel: adapta el encargo a lo que haya.
2. **Arma el encargo** con este texto, completo, y el material pegado tal cual y rotulado por archivo. No incluyas la conversación, tus opiniones ni lo que el usuario te dijo:

   ```
   Rompe esto, no lo pules. Tienes el material de una pieza de contenido hecha con ayuda de IA (brief, guion, shotlist u otros textos). Busca supuestos falsos, huecos de historia, escenas sin plano que las cubra, planos sin propósito real respecto de que_debe_lograr del brief, planos que contradicen fuera_de_alcance, contradicciones entre archivos, duraciones que no cuadran con el formato, y cosas que un modelo de video no podrá hacer. No elogies, no reescribas el material y no propongas versiones nuevas. Responde en español de México con una lista priorizada (alta, media, baja) de 4 a 8 hallazgos. Cada hallazgo lleva: qué falla, evidencia concreta (archivo y escena o plano, citando el texto) y por qué importa. Solo revisas texto; no opines de clips ni de imágenes. No uses herramientas: responde solo con texto. Empieza con una línea "Modelo que revisa: <tu nombre de modelo>".

   === brief.md ===
   <contenido>

   === guion.md ===
   <contenido>

   === shotlist.yaml ===
   <contenido>
   ```

3. **Consigue el revisor.**
   - Con Agent: lanza el subagente con el parámetro `model` igual al alias elegido y el encargo anterior como prompt.
   - Sin Agent: muestra el encargo completo en un solo bloque de código para copiar, con la instrucción de usar otro modelo en un chat nuevo, y espera.
4. **Presenta los hallazgos** numerados H1..Hn, en orden de prioridad, cada uno con su evidencia (archivo y escena o plano). Di qué modelo revisó (por ejemplo "Revisó: opus"; si el revisor declaró otro nombre, dilo tal cual). Si algo vino sin evidencia, quítalo o pide la evidencia; no lo presentes como hallazgo.
5. **El usuario decide, de uno en uno.** Pregunta solo por H1: "¿Lo incorporas o lo rechazas? Si lo incorporas, dime qué vas a cambiar; si lo rechazas, dime tu razón." Espera. Registra su respuesta en sus palabras y pasa a H2, y así hasta el último. Rechazar es válido si hay razón; si responde "no sé", ayúdalo con una pregunta, sin decidir.
6. **Entrega el bloque de hallazgos**, con este formato, un hallazgo por línea y las respuestas del usuario:

   ```
   ## Reto en frío (AAAA-MM-DD, revisó: <modelo>)

   - H1: <hallazgo en una línea> → Incorporo: <qué cambió o cambiará, con sus palabras>
   - H2: <hallazgo en una línea> → Rechazo: <su razón>
   ```

   Dile dónde ponerlo: al final del `aprendizajes.md` del proyecto, o en sus notas si no usa archivos. Con acceso a archivos, no lo escribas tú: ofrécelo y, si el usuario te lo pide después de terminar el reto, es un paso aparte. Usa la fecha que él te dé; si no la sabes, deja `AAAA-MM-DD`.
7. **Cierra** con una sola pregunta: "¿Quieres aplicar alguno de los cambios que dijiste que incorporas, o prefieres hacerlos tú?"

## Checks

- El revisor es un modelo distinto al que ayudó a escribir el material, o el usuario fue avisado de que no lo es.
- El revisor solo recibió el material, nunca la conversación.
- Cada hallazgo tiene evidencia citada.
- Cada hallazgo tiene una respuesta del usuario con sus palabras; ninguna la escribiste tú.
- No se editó ningún archivo.
