---
name: wiki
description: Construye y consulta tu wiki personal de conceptos con fuente real. Úsalo cuando digas "guarda esto en mi wiki", "ingiere este PDF", "resume y archiva esta transcripción", "crea una ficha de", "qué dice mi wiki sobre", "conecta mis fichas" o "actualiza mi índice". Convierte texto pegado, .md, PDF o transcripciones en fichas citables y responde citándolas.
license: CC-BY-4.0
---

# Wiki

Objetivo: que tu conocimiento quede en fichas cortas, con fuente verificable, que luego sirvan para trabajar (briefs, guiones, artículos) sin que Claude invente. Formato completo de la ficha y ejemplos: `references/fichas.md`.

## Cómo te comportas

- Pregunta antes de explicar, una pregunta por turno. Modo rápido si lo piden ("solo dime qué sigue").
- Las sugerencias (conexiones, fichas nuevas) van marcadas como "sugerencia" y no se escriben sin un sí.
- Español de México, de tú, breve.

## Regla dura: la fuente nunca se inventa

Una ficha solo puede citar como fuente:
- un archivo de `RAW/` (Claude Code),
- un texto que la persona pegó en la conversación (escribe "pegado por ti, AAAA-MM-DD" con la fecha real de hoy),
- una URL que la persona dio.

Si no hay ninguna, la fuente es `sin verificar`. Nunca pongas un autor, libro, enlace, fecha o cifra que no aparezca en lo que la persona te dio. Si la fuente trae un dato dudoso, deja la duda anotada en la ficha en vez de corregirla de memoria.

## Ingesta

Acepta texto pegado, `.md`, PDF o transcripción. Para cada fuente:

1. Extrae el texto. Si no puedes leer el archivo (PDF escaneado, imagen), dilo y pide el texto.
2. Propón una lista corta de conceptos candidatos (de 3 a 8) y pregunta cuáles quiere. No fichas todo por defecto.
3. Redacta cada ficha con las **palabras propias** de la persona o tuyas parafraseando, de 2 a 4 líneas; no copies párrafos largos de la fuente. Usa exactamente este formato, sin frontmatter YAML:

   ```
   # <Concepto>
   Idea: <2 a 4 líneas>
   Fuente: <archivo de RAW/, "pegado por ti, AAAA-MM-DD", URL que dio la persona, o "sin verificar">
   Ejemplo: <opcional>
   Relacionado: [[otro-concepto]]
   ```
4. Actualiza el índice y propone `Relacionado` solo hacia fichas que existen.
5. Antes de escribir, define la vía (ver abajo). Con archivos, muestra las fichas y pregunta si las guardas. Sin archivos, pregunta una vez si quiere el `wiki.md` completo o modo ligero.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

- Si existe `perfil.md`, léelo antes de empezar; si no, sugiere `inicio`.
- Guarda la fuente original tal como llegó en `wiki/RAW/` (nombre claro con fecha, por ejemplo `2026-11-26-entrevista-x.md`). Nunca edites lo que ya está en `RAW/`. Si no hay archivo original (texto pegado), guarda el texto pegado como archivo nuevo en `RAW/` y cítalo.
- Una ficha por concepto en `wiki/conceptos/<slug>.md`. Slug en minúsculas con guiones, sin acentos.
- Actualiza `wiki/indice.md` en cada ingesta: lista por tema, un enlace por ficha.
- Si una ficha con ese slug ya existe, muéstrala y pregunta si fusionas, la actualizas o creas otra. No sobrescribas sin un sí.
- Reglas del wiki (`wiki/esquema.md`): `RAW/` no se edita; una ficha por concepto con fuente; el índice se actualiza en cada ingesta; los `[[slug]]` apuntan a fichas que existen.
- Revisión rápida al cerrar: cada `[[slug]]` de las fichas tocadas tiene archivo; cada ficha aparece en el índice.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el `wiki.md` completo actualizado para tu Proyecto, o modo ligero (las fichas en el chat y copias lo que te sirva)?"

- Con archivo: las fichas son secciones `## <concepto>` dentro de un solo `wiki.md`, con el mismo formato que una ficha. Entrega **el archivo completo actualizado** y la instrucción exacta: "Reemplaza `wiki.md` en los archivos de tu Proyecto por este."
- Si el Proyecto ya tiene `wiki.md` y `perfil.md`, léelos primero y respeta las fichas existentes; parte de la versión que la persona tiene, no de una que recuerdes.
- No hay `RAW/`: la fuente de una ficha nueva es "pegado por ti, AAAA-MM-DD" o la URL dada. Recomienda que la persona guarde el original en sus archivos.
- **Aviso de tamaño:** si `wiki.md` supera unos 40 conceptos o 60 KB, avísalo: "Tu wiki ya es grande para un solo archivo. Conviene pasar a Claude Code (una ficha por archivo) o dividirlo por tema (`wiki-tema.md`)." Ofrece ayuda con cualquiera de las dos y no sigas agrandando en silencio.

## Responder preguntas

- Responde con lo que dicen las fichas y cítalas por nombre: "según la ficha [[concepto]] (fuente: ...)".
- Si el wiki no cubre la pregunta, dilo. Si aun así aportas conocimiento general, márcalo explícitamente como "fuera del wiki" y sepáralo de lo que sí viene de las fichas. No completes un hueco del wiki con algo que suene a cita.
- Si dos fichas se contradicen, muéstralas las dos y no resuelvas por tu cuenta.
- Si la pregunta pide una fuente que el wiki no tiene (un autor, una cifra, un año), la respuesta es que no está en el wiki y qué fuente haría falta.

## Proponer conexiones

Cuando haya varias fichas, ofrece como sugerencia pares con relación real (causa, ejemplo de, contrasta con, parte de) y di en una línea por qué. Se añaden a `Relacionado` solo con un sí, y solo hacia fichas existentes.

## Checks antes de cerrar

- Ninguna ficha tiene una fuente que la persona no haya dado.
- Los enlaces `[[...]]` apuntan a fichas reales.
- El índice (Claude Code) o el archivo completo entregado (claude.ai) está al día.
- Dijiste qué se guardó, dónde, y qué falta (fuentes "sin verificar" pendientes).

## Cierre

Una sola pregunta: "¿Quieres fichar otra fuente, o usamos el wiki para un `brief`?"
