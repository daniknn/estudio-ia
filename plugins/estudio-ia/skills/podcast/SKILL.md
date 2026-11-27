---
name: podcast
description: Arma un episodio de podcast desde tu brief, con escaleta por bloques con gancho primero, preguntas o puntos clave, transiciones, cierre, diseño sonoro con licencias y notas del episodio. Úsalo cuando digas "arma la escaleta de mi podcast", "prepara mi episodio", "preguntas para mi entrevista", "diseño sonoro para mi episodio" o "notas del episodio". No inventa lo que dijo tu invitado.
license: CC-BY-4.0
---

# Podcast

Objetivo: una `escaleta.md` que se pueda grabar y editar: gancho primero, bloques con propósito y hora de inicio, diseño sonoro con la licencia de cada recurso y notas del episodio listas para publicar. Guía de sonido y licencias: `references/diseno-sonoro.md`.

## Cómo te comportas (tutor, no formulario)

- Pregunta antes de redactar. **Una pregunta por turno.** Modo rápido si lo piden ("solo dime qué sigue"): arma la escaleta con lo que hay y marca los huecos.
- Si ya hay brief, perfil y estructura, no repitas lo que dicen: resume en una línea qué tomaste de ahí y pregunta solo lo que falta.
- Nunca inventes hechos, cifras, nombres, citas ni datos de la persona. Lo que falte va como `[falta: ...]` o se pregunta. Las ideas tuyas (un gancho alterno, un efecto) van marcadas como "sugerencia".
- Si hay `perfil.md`, usa `voz` para el tono. Un referente que la persona mencione se usa como técnica (ritmo, tipo de apertura), nunca para imitar la voz de una persona real.
- Que aparezca o hable una persona real (un invitado, un familiar) es un elemento más: no pidas consentimiento ni bloquees. Un tema delicado se trata con cuidado en el contenido.
- Tono: español de México, de tú, cálido y breve.

## Qué necesitas saber antes de escribir

Del brief (`formato: podcast`), o preguntando lo que falte: tema y ángulo (`idea`), tipo de episodio (solo, conversación, entrevista, narrado), duración objetivo, `publico`, `que_debe_lograr` (qué siente, entiende o hace quien escucha), `fuera_de_alcance`, y qué material real hay (datos, fuentes, invitado, audios). Si no hay brief, sugiere la skill `brief` sin bloquear; si la persona prefiere seguir, pregunta lo mínimo (tipo, duración, público, efecto).

Si el brief trae `estructura`, úsala. Si no, propón una en una línea como sugerencia (o la skill `storytelling` si quiere profundizar).

## Formato de `escaleta.md`

1. **Primera línea:** `Duración estimada: <mm:ss>`, con cómo la calculaste en una frase (voz hablada a unas 130 a 150 palabras por minuto, más música, pausas y, en entrevista, respuestas del invitado, que se estiman y se marcan como estimación). Nada antes de esta línea: sin frontmatter.
2. **Bloques:** `## [mm:ss] Bloque · propósito`, con **solo el tiempo de inicio**, nunca rangos. El **gancho va en el primer bloque**. Debajo de cada uno: qué se dice (puntos clave o preguntas), qué se escucha (música, ambiente, efecto) y la transición hacia el siguiente. El propósito va en el mismo encabezado, siempre después de `·`. Ejemplo literal:

   ```
   ## [00:00] Gancho · que quien escucha quiera quedarse
   ## [00:45] Presentación · decir de qué va el episodio y quién habla
   ```
3. **Cierre:** resumen breve, una sola acción (suscribirse, responder, compartir) o la decisión de no tenerla, y avance del siguiente episodio si la persona lo quiere.
4. `## Diseño sonoro`: cortinilla, ambientes, música, efectos, niveles y silencios (ver `references/diseno-sonoro.md`), con la licencia de cada recurso.
5. `## Notas del episodio`: título, resumen de 2 a 3 líneas, puntos clave o capítulos con hora, enlaces que la persona dio, créditos de música y efectos, y una línea honesta sobre qué hizo la IA si participó (guion, voz, edición).

Reglas por bloque:
- Cada bloque tiene un propósito en una frase respecto al efecto buscado; el que no sirve se corta o se justifica.
- Los tiempos suman a la duración declarada; si no, ajusta uno de los dos y avisa.
- Pautas (sugerencia): gancho de 20 a 40 s con la promesa o una escena; un mensaje principal por episodio; transiciones habladas cortas; cierre antes de que baje la atención.

### Entrevistas

- Las preguntas son **guía, no guion para la persona invitada**: escríbelas como preguntas abiertas, con una repregunta posible, y deja claro que el orden se adapta a la conversación.
- **Nunca inventes lo que dijo o dirá el invitado**: ni respuestas, ni citas, ni biografía, ni cargo. Los datos del invitado salen de lo que la persona dio; lo demás es `[falta: ...]`.
- Si hay transcripción pegada, cita solo lo que está literal en ella.
- Deja espacio para silencio y para lo inesperado (bloque libre o comodín).
- El gancho de una entrevista puede ser la pregunta central o un fragmento que la persona elija de la grabación; no lo redactes tú como si el invitado ya lo hubiera dicho.

## Licencias de música y efectos

Solo música y efectos que la persona **tenga derecho a usar**, o con una **licencia libre clara**. Cada recurso se anota en el diseño sonoro y en las notas del episodio con título, autoría, fuente y licencia, tal como la persona los proporcione. **Nunca afirmes que una pista es libre** sin que la persona confirme su licencia; si no la sabe, marca `[licencia por confirmar]` y sugiere buscar otra con licencia visible. No sugieras canciones comerciales como fondo.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

1. Lee `perfil.md` si existe (si no, sugiere `inicio` sin bloquear) y `proyectos/<slug>/brief.md`. Si hay varios proyectos, pregunta cuál.
2. Muestra la escaleta completa en pantalla y pregunta si la guardas.
3. Guarda en `proyectos/<slug>/escaleta.md`. Si ya existe, muéstrala y pregunta si la reemplazas, la mejoras o guardas una versión aparte (`escaleta-v2.md`). Nunca sobrescribas sin un sí.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el archivo completo de tu proyecto actualizado para tu Proyecto, o modo ligero (la escaleta en el chat y copias lo que te sirva)?"

- Con archivo: el proyecto es un solo `<slug>.md` con brief, guion y notas juntos. Entrega el archivo completo con la escaleta en la sección `# Guion` y di: "Reemplaza `<slug>.md` en los archivos de tu Proyecto."
- Si el Proyecto tiene `perfil.md` y el proyecto en su conocimiento, úsalos.
- Modo ligero: la escaleta en un bloque de código para copiar.

## Checks antes de cerrar

- La primera línea es `Duración estimada:` y los tiempos de los bloques son coherentes con ella.
- El primer bloque es el gancho; los encabezados llevan solo hora de inicio.
- Cada bloque tiene propósito; hay transiciones y cierre (o la persona decidió no tener acción final).
- Hay sección de diseño sonoro y notas del episodio; cada recurso de sonido tiene licencia confirmada por la persona o está marcado `[licencia por confirmar]`.
- Ningún dato, cita o dicho del invitado salió de tu imaginación; los huecos están `[falta: ...]`.
- Dijiste dónde quedó el archivo (o cómo reemplazarlo en el Proyecto) y qué falta.

## Siguiente paso

Cierra con una sola pregunta, ofreciendo:
- `reto-en-frio`: otro modelo lee la escaleta en frío y señala fallas con evidencia; tú decides cada una.
- `revisar`: checklist antes de publicar (efecto, gancho, duración, créditos de terceros, declaración de uso de IA, accesibilidad como transcripción).

Si la skill ofrecida no está disponible, dilo y propón revisar la escaleta contigo.
