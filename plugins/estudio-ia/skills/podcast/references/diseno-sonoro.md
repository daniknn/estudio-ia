# Diseño sonoro para un episodio

Guía para la sección `## Diseño sonoro` de `escaleta.md`. Los números son puntos de partida (sugerencia), no reglas: la persona decide y ajusta al oído.

## Licencias primero

- Usa solo música y efectos que la persona **tenga derecho a usar** (los grabó, los compró con licencia, se los dio quien los hizo) o que tengan una **licencia libre clara** y visible.
- Cada recurso se registra con: título, autoría, fuente (enlace que la persona dio) y licencia, tal como los dio la persona. Esos datos van en el diseño sonoro y en los créditos de las notas del episodio.
- **Nunca digas que una pista o un efecto es libre** sin que la persona confirme la licencia. Si no la sabe, escribe `[licencia por confirmar]` y sugiere buscar otro recurso con la licencia a la vista.
- Las licencias libres suelen pedir atribución, prohibir uso comercial o prohibir obras derivadas: pide a la persona que lea la condición exacta y la anote. No resumas una licencia de memoria.
- Canciones comerciales, tonos de series o fragmentos de otros programas no son fondo musical por defecto: si la persona quiere uno, dile que necesita autorización de quien lo publicó.
- Voces clonadas o música generada con IA: anota la herramienta y confirma con la persona sus condiciones de uso.

## Cortinilla (entrada y salida)

- Un identificador sonoro corto del programa: de 5 a 15 segundos la entrada, de 5 a 10 la salida.
- Va después del gancho (sugerencia): el episodio abre con la promesa o la escena y luego suena la cortinilla. Si abre con cortinilla, que sea breve.
- Una sola cortinilla por programa para que se reconozca; cambia solo con un motivo.
- Indica en la escaleta cuándo entra, si la voz entra encima y cuándo baja.

## Ambientes

- Sonido de lugar (calle, mercado, oficina, agua) que ubica al público en una escena. Útil en crónica y narrado.
- Grabación propia siempre que se pueda: es la opción con menos riesgo de licencia.
- Debe sentirse, no competir con la voz. Entra antes de la primera palabra de la escena y se queda abajo.
- Evita ambientes que se repitan en bucle audible.

## Música

- Función por bloque: abrir, sostener, marcar un cambio, cerrar. Sin función, sin música.
- Instrumental y sin letra bajo la voz; una letra compite con las palabras.
- Cama musical bajo la voz, de 12 a 20 dB por debajo de la voz (sugerencia). Sube solo en pausas y transiciones.
- Cambios de música en los cambios de bloque, no a mitad de una idea.
- Registra cada pista con su licencia (ver arriba).

## Efectos

- Sirven para subrayar una acción, una transición o un chiste, con moderación: el abuso cansa.
- Cortos y limpios; cada uno con su nota de licencia.
- Mejor un efecto grabado por la persona (una puerta, un teclado) que uno de origen dudoso.
- En la escaleta se escriben dentro del bloque donde suenan, por ejemplo `[efecto: puerta, 2 s]`.

## Niveles

- Voz: referencia de unos -16 LUFS integrados en estéreo (-19 en mono) y picos por debajo de -1 dBFS (sugerencia, es un objetivo común en plataformas de podcast; confirma lo que pida donde publicas).
- Mismo nivel de voz entre bloques, entre invitados y entre episodios.
- Música y ambiente siempre por debajo de la voz; baja la música antes de que entre la voz, no encima.
- Escucha el episodio con audífonos y en un altavoz de celular: si en el celular no se entiende, sube la voz o baja la cama.
- Exporta una copia a 128 kbps o más en MP3 y guarda el original sin comprimir.

## Silencio

- El silencio también es diseño: una pausa de 1 a 2 segundos antes de una frase importante, después de una pregunta fuerte o al cambiar de escena.
- No limpies toda la respiración ni todo el aire de la grabación: suena artificial. Quita ruido de fondo, no silencios.
- En entrevista, conserva el silencio de quien piensa antes de responder si aporta.
- Evita el silencio muerto (más de 3 o 4 segundos sin ambiente ni voz) salvo que sea intencional y esté anotado.

## Formato en la escaleta

```
## Diseño sonoro
- Cortinilla de entrada: <descripción> · duración · licencia: <dato confirmado por la persona o [licencia por confirmar]>
- Ambiente: <descripción> · bloques donde suena · fuente: <grabación propia u otra>
- Música: <función por bloque> · nivel respecto a la voz · licencia
- Efectos: <lista con bloque y duración> · licencia
- Silencios: <dónde y cuánto>
- Niveles: voz objetivo, cama, picos
```
