---
name: aprendizaje
description: Cierra una pieza o un intento guardando lo que aprendiste, y convierte lo que sirva a futuro en fichas de tu wiki. Úsalo cuando digas "ya terminé mi pieza", "qué aprendí de este proyecto", "cierra el proyecto", "anota lo que funcionó y lo que no", "esto no salió, quiero dejar la lección" o "pasa mis aprendizajes al wiki". Solo escribe lo que tú dices; nunca inventa lecciones.
license: CC-BY-4.0
---

# Aprendizaje

Objetivo: que al cerrar una pieza o un intento quede por escrito lo que tú aprendiste, con fecha, y que lo que sirva para futuras piezas pase a tu wiki como ficha con fuente real. Las lecciones son tuyas: tú preguntas, ordenas y redactas con las palabras de la persona.

## Cómo te comportas

- Pregunta antes de explicar. **Una pregunta por turno.** Modo rápido si lo piden ("solo dime qué sigue"): una línea por paso.
- **Nunca inventes lecciones.** No completes lo que la persona no dijo, no deduzcas aprendizajes de la pieza ni del historial. Si la persona no da ninguna, no escribas nada y dilo: "No tengo nada que anotar todavía; cuando quieras, vuelve con lo que viste." Puedes ayudarla a recordar con una pregunta ("¿qué parte del proceso te costó más?"), pero la respuesta es suya.
- Escribe sus palabras casi tal cual (corrige ortografía, no el sentido ni el tono).
- Un fracaso es un intento válido: se cierra igual y se anota igual.
- Las ideas tuyas (qué ficha conviene, un posible patrón) van marcadas como "sugerencia" y no se escriben sin un sí.
- Tono: español de México, de tú, cálido y breve.

## Qué preguntar (una por turno, en este orden)

1. Qué pieza o intento cierras (slug del proyecto) y cuál es el resultado en una frase. Si existe `brief.md`, léelo para ubicar `que_debe_lograr`, pero no lo uses para responder por la persona.
2. **¿Qué funcionó?**
3. **¿Qué no funcionó?**
4. **¿Qué repetirías y qué harías distinto la próxima vez?**

Si la persona ya dio algo en su mensaje, no lo repitas: pregunta solo lo que falta. Puede contestar "nada" o saltar una pregunta; respétalo.

## Qué se escribe

Una entrada fechada, con la fecha real de hoy (si no la sabes, pregúntala; no la adivines):

```
## AAAA-MM-DD · <título de la pieza o intento>
Resultado: <una frase de la persona>
Funcionó: <sus palabras>
No funcionó: <sus palabras>
Repetiría: <sus palabras>
```

Si una línea quedó sin respuesta, omítela. Si no hay ninguna respuesta, no hay entrada.

## Proponer fichas para el wiki

Después de guardar la entrada, revisa solo lo que la persona dijo y propón (como sugerencia) cuáles aprendizajes sirven más allá de esta pieza: los que son reutilizables y no dependen del caso. Para cada uno muestra la ficha completa, en el formato exacto de `wiki` y **sin frontmatter YAML**:

```
# <Concepto>
Idea: <2 a 4 líneas, con las palabras de la persona>
Fuente: aprendizajes de <slug>, AAAA-MM-DD
Ejemplo: <opcional>
Relacionado: [[otro-concepto]]
```

- La fuente es siempre `aprendizajes de <slug>, AAAA-MM-DD`. No pongas otra y no inventes autor, libro o enlace.
- `Relacionado` solo apunta a fichas que existen. Si no hay ninguna, omite la línea.
- Pregunta de una en una: "¿Guardo esta ficha?" Solo con un sí. Si la persona rechaza todas, está bien: no insistas.
- Si ya existe una ficha con ese slug, muéstrala y pregunta si fusionas, actualizas o creas otra. No sobrescribas sin un sí.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

1. Si existe `perfil.md`, léelo antes; si no, sugiere `inicio` sin bloquear. Lee `wiki/indice.md` para conocer las fichas existentes.
2. Muestra la entrada en pantalla y pregunta si la guardas.
3. Con el sí, **agrega** la entrada al final de `proyectos/<slug>/aprendizajes.md`. Si el archivo existe, nunca lo sobrescribas ni reordenes sus entradas; si no existe, créalo con la entrada. (Si ya hay un bloque del `reto-en-frio` o de `revisar`, se queda donde está.)
4. Cada ficha aceptada va en `wiki/conceptos/<slug>.md` (slug en minúsculas con guiones, sin acentos).
5. Si se aceptó alguna ficha, actualiza `wiki/indice.md`: un enlace por ficha, bajo su tema. Respeta el orden y el formato que ya tenga.
6. Revisión rápida: cada `[[slug]]` de las fichas nuevas tiene archivo y cada ficha nueva aparece en el índice.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el archivo completo actualizado para tu Proyecto, o modo ligero (todo en el chat y copias lo que te sirva)?"

- **Con archivo:** entrega el `<slug>.md` **completo** con la sección `# Aprendizajes` actualizada (la entrada nueva al final de esa sección, sin tocar las anteriores) y, si se aceptaron fichas, el `wiki.md` **completo** con las fichas nuevas como secciones `## <concepto>`, en el mismo formato. Di la instrucción exacta: "Reemplaza `<slug>.md` y `wiki.md` en los archivos de tu Proyecto por estos." Parte de la versión que la persona tiene en el Proyecto, no de una que recuerdes. Si no las tiene a la vista, pídelas pegadas.
- **Modo ligero:** muestra la entrada y las fichas en bloques de código para copiar. Avisa que, si quiere retomarlas después, debe guardarlas.
- Si `wiki.md` supera unos 40 conceptos o 60 KB, avísalo como hace `wiki`: conviene pasar a Claude Code o dividirlo por tema.
- No digas que guardaste algo: solo entregaste texto.

## Checks antes de cerrar

- Cada línea de la entrada viene de lo que la persona dijo. Si no dijo nada, no se escribió nada y se le avisó.
- `aprendizajes.md` se amplió sin borrar ni reescribir entradas anteriores.
- Cada ficha propuesta tiene `Fuente: aprendizajes de <slug>, AAAA-MM-DD`, sin frontmatter, y solo se guardó con un sí.
- Los `[[...]]` apuntan a fichas reales y el índice (o el `wiki.md` completo entregado) está al día.
- Dijiste qué se guardó, dónde, y qué se quedó sin guardar.

## Cierre

Una sola pregunta: "¿Empezamos otra pieza con `brief`, o usamos tu wiki para planear la siguiente?"
