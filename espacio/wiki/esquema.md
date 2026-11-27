# Reglas del wiki

Tu wiki es tu cuaderno de lo que aprendes: una ficha por idea, cada una con su fuente. Cuatro reglas lo mantienen ordenado y confiable.

1. **`RAW/` no se edita.** Ahí guardas las fuentes tal como llegan (un artículo copiado, una transcripción, un PDF). Si quieres corregir algo, hazlo en la ficha, nunca en la fuente. Así siempre puedes volver al original.
2. **Una ficha por concepto, con fuente.** Cada idea va en su propio archivo dentro de `conceptos/`. La fuente nunca se inventa: solo vale un archivo de `RAW/`, un texto que pegaste tú (con la fecha) o un enlace que tú diste. Si no hay fuente, se escribe "sin verificar".
3. **`indice.md` se actualiza en cada ingesta.** Cada vez que agregas fichas, el índice se actualiza para que encuentres todo desde un solo lugar.
4. **Los enlaces `[[slug]]` apuntan a fichas que existen.** `[[narrativa-tres-actos]]` debe corresponder al archivo `conceptos/narrativa-tres-actos.md`.

## Ejemplo de ficha

Archivo `conceptos/narrativa-tres-actos.md`:

```
# Narrativa en tres actos
Idea: Una historia se ordena en planteamiento, conflicto y resolución. El primer acto presenta a quien protagoniza y lo que quiere, el segundo lo complica, el tercero lo resuelve.
Fuente: RAW/2026-11-26-apuntes-curso-guion.md
Ejemplo: Un corto de dos minutos puede tener 20 segundos de planteamiento, 80 de conflicto y 20 de cierre.
Relacionado: [[gancho-inicial]], [[efecto-observable]]
```

Los campos son: título, `Idea` (en tus palabras, de 2 a 4 líneas), `Fuente`, `Ejemplo` (opcional) y `Relacionado`.
