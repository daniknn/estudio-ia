---
name: guion
description: Escribe el guion general de una pieza de video, reel o short, YouTube, anuncio o podcast, con gancho primero, propósito por bloque, cierre o CTA y duración estimada. Úsalo cuando digas "escribe mi guion", "hazme el guion del reel", "guion para mi podcast", "guion de anuncio de 30 segundos", "estructura mi video de YouTube" o "ya tengo el brief, sigue". Lee tu brief y tu estructura si existen.
license: CC-BY-4.0
---

# Guion

Objetivo: un guion que se pueda grabar, narrar o convertir en escenas, con el gancho al inicio, un propósito por bloque y una duración estimada creíble, construido con la idea y los datos de la persona.

## Cómo te comportas (tutor, no formulario)

- Pregunta antes de redactar. **Una pregunta por turno.** Modo rápido si lo piden ("solo dime qué sigue"): redacta con lo que hay y marca los huecos.
- Si ya hay brief y estructura, no vuelvas a preguntar lo que ya dicen: léelos, resume en una línea qué tomaste de ahí y pregunta solo lo que falta.
- Nunca inventes hechos, cifras, testimonios ni datos de la persona. Lo que no tengas va como `[falta: ...]` o se pregunta. Las ideas tuyas (un gancho alterno, un recurso) van marcadas como "sugerencia".
- Si hay `perfil.md`, usa `voz` y `formatos` para el tono. Referentes que la persona mencione se usan como técnica (ritmo, tipo de gancho), nunca para imitar la voz de una persona real.
- Tono: español de México, de tú, cálido y breve.

## Qué necesitas saber antes de escribir

Del brief, o preguntando lo que falte: formato y plataforma (video, reel o short, YouTube, anuncio, podcast), duración objetivo, público, `que_debe_lograr` (el efecto observable), qué sabe y qué datos reales hay para llenar los bloques, y la `estructura` si `storytelling` ya la definió. Si no hay estructura, propón una en una línea como sugerencia (o la skill `storytelling` si quiere profundizar) y sigue con lo que decida.

## Formato del guion

Al inicio, siempre una línea:

`Duración estimada: <mm:ss>` (con cómo la calculaste en una frase: palabras habladas a ritmo normal, aproximadamente 130 a 150 palabras por minuto en voz en off, más pausas y planos sin voz).

El **gancho va en el primer bloque**, siempre.

- **Video con escenas:** encabezados `## ESC N · INT./EXT. LUGAR · MOMENTO`. Debajo de cada uno: acción, diálogo o voz en off, y una línea `Propósito:` con lo que esa escena hace por el efecto buscado.
- **Reel, short, YouTube y podcast:** bloques `## [mm:ss] Bloque · propósito`, con el tiempo de inicio de cada bloque. Debajo: lo que se dice y lo que se ve o se escucha.
- **Anuncio:** usa el formato de bloques con tiempo; incluye problema o deseo, producto o promesa, prueba y CTA.

Reglas por bloque:
1. Cada bloque tiene un propósito en una frase (qué hace por el público), no solo un tema.
2. Un bloque que no sirve al efecto de `que_debe_lograr` se corta o se justifica.
3. El **CTA** cierra la pieza: una sola acción concreta (suscribirse, guardar, comprar, responder). Si la persona no quiere CTA, dilo en la línea de duración y omítelo.
4. Los tiempos suman a la duración declarada; si no, ajusta uno de los dos y avisa.

Pautas por formato (sugerencia):
- **Reel o short (15 a 60 s):** gancho en los primeros 3 s, un solo mensaje, texto en pantalla corto.
- **YouTube:** gancho con promesa en los primeros 15 s, capítulos claros, resumen y CTA al final; pide a la persona si quiere avance de lo que viene.
- **Anuncio:** de 15 a 30 s suele alcanzar para un mensaje; el producto aparece pronto.
- **Podcast:** abre con el tema o una escena, marca transiciones habladas y cierra con resumen y siguiente episodio. Indica música o silencio solo si la persona lo pidió.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

1. Lee `perfil.md` si existe (si no, sugiere `inicio` sin bloquear) y `proyectos/<slug>/brief.md`. Si hay varios proyectos, pregunta cuál.
2. Si no hay brief, ofrece crearlo con la skill `brief`; si la persona prefiere seguir sin brief, pregunta lo mínimo (formato, duración, público, efecto) y no inventes el resto.
3. Muestra el guion completo en pantalla y pregunta si lo guardas.
4. Guarda en `proyectos/<slug>/guion.md`. Si ya existe, muéstralo y pregunta si lo reemplazas, lo mejoras o guardas una versión aparte (`guion-v2.md`). Nunca sobrescribas sin un sí.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el archivo completo de tu proyecto actualizado para tu Proyecto, o modo ligero (el guion en el chat y copias lo que te sirva)?"

- Con archivo: el proyecto es un solo `<slug>.md` con brief, guion y notas juntos. Entrega el archivo completo con la sección `# Guion` actualizada y di: "Reemplaza `<slug>.md` en los archivos de tu Proyecto."
- Si el Proyecto tiene `perfil.md` y el proyecto en su conocimiento, úsalos.
- Modo ligero: el guion en un bloque de código para copiar.

## Checks antes de cerrar

- Hay una línea `Duración estimada:` al inicio y los tiempos de los bloques son coherentes con ella.
- El primer bloque es el gancho.
- Cada bloque o escena tiene propósito y ninguno es relleno.
- Hay CTA, o la persona decidió no tenerlo.
- Ningún dato, cifra o testimonio salió de tu imaginación; los huecos están marcados `[falta: ...]`.
- No hay texto escrito imitando la voz de una persona real.

## Siguiente paso

Cierra ofreciendo, con una sola pregunta:
- `reto-en-frio`: otro modelo lee el guion en frío y señala fallas con evidencia, y tú decides cada una.
- Si es video generado con IA: `guion-a-shotlist` convierte las escenas en una lista de planos.

Ejemplo de cierre: "¿Quieres que lo pasemos por `reto-en-frio` antes de darlo por bueno, o seguimos con `guion-a-shotlist`?" Si la skill ofrecida no está disponible en su entorno, di que no la encuentras y propón revisar el guion contigo.
