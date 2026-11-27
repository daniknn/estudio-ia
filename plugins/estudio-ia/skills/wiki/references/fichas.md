# Formato de la ficha

Una ficha por concepto. En Claude Code es el archivo `wiki/conceptos/<slug>.md`. En claude.ai es una sección `## <Concepto>` dentro de `wiki.md`, con las mismas líneas.

```
# <Concepto>
Idea: <2 a 4 líneas en palabras propias>
Fuente: <archivo de RAW/, URL que dio el usuario, o "sin verificar">
Ejemplo: <opcional>
Relacionado: [[otro-concepto]], [[otro]]
```

## Reglas

- `Idea`: de 2 a 4 líneas, parafraseadas. No pegues párrafos de la fuente.
- `Fuente`: solo un archivo de `RAW/`, un texto pegado por el usuario (escribe "pegado por ti, AAAA-MM-DD") o una URL que el usuario dio. Sin nada de eso, `sin verificar`. Nunca un autor, libro o enlace que nadie dio.
- `Ejemplo`: opcional. Si viene de la fuente, dilo; si lo propones tú, márcalo "sugerencia".
- `Relacionado`: solo `[[slug]]` de fichas que existen. Sin conexiones reales, omite la línea.
- Slug: minúsculas, guiones, sin acentos (`gancho-de-apertura`).

## Ejemplo bueno 1 (fuente en RAW)

```
# Gancho de apertura
Idea: Los primeros segundos de una pieza deben prometer algo concreto al espectador para que decida seguir. Una pregunta o una imagen inesperada funcionan mejor que una presentación de quién habla.
Fuente: wiki/RAW/2026-11-20-notas-taller-de-video.md
Ejemplo: Abrir con el resultado final ("así quedó mi cocina en 3 días") y luego mostrar el proceso.
Relacionado: [[retencion-de-audiencia]]
```

Por qué es buena: la idea está en palabras propias, la fuente es un archivo real de `RAW/`, el ejemplo viene de la fuente y el enlace apunta a una ficha existente.

## Ejemplo bueno 2 (texto pegado, sin verificar el dato)

```
# Regla de los tercios
Idea: Dividir el encuadre en una cuadrícula de 3 por 3 y colocar el sujeto en una de las intersecciones da composiciones menos estáticas que centrarlo.
Fuente: pegado por ti, 2026-11-26
Relacionado: [[encuadre]]
```

Por qué es buena: la fuente es el texto que el usuario pegó, con fecha real. Si en ese texto hubiera una cifra dudosa, la ficha la dejaría anotada como duda y no la corregiría de memoria.

## Ejemplo malo

```
# Storytelling
Idea: Según el libro "El arte de contar" de Martín Ruiz (2019), el 80% de las historias exitosas usa tres actos. Es la técnica que usan todos los grandes directores.
Fuente: Ruiz, M. (2019). El arte de contar. Editorial Norte.
Relacionado: [[tres-actos]], [[heroe-mil-caras]]
```

Qué falla:
- La fuente (autor, libro, año, editorial) y la cifra del 80% no vienen de nada que el usuario haya dado: están inventadas. Debió decir `sin verificar` y no incluir la cifra.
- La idea es demasiado amplia ("storytelling") y mezcla un dato con una opinión; son dos conceptos.
- `Relacionado` apunta a `[[tres-actos]]` y `[[heroe-mil-caras]]`, que no existen como fichas, así que rompe la regla de los enlaces.
