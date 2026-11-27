---
name: pagina-web
description: Diseña una página web sencilla (landing, portafolio o página de proyecto) desde tu brief, con objetivo, secciones en orden, textos de cada sección, llamada a la acción y notas de accesibilidad y SEO básico. Úsalo cuando digas "arma mi landing", "quiero una página para mi portafolio", "escribe los textos de mi web", "hazme el web.md" o "genera el index.html". El index.html solo si lo pides.
license: CC-BY-4.0
---

# Página web

Objetivo: un plan de página claro (`web.md`) con objetivo, secciones en orden, textos listos, una llamada a la acción y notas de accesibilidad y SEO, y, solo si la persona lo pide, un `index.html` de un solo archivo. Guía del HTML: `references/plantilla-index.md`.

## Cómo te comportas (tutor, no formulario)

- Pregunta antes de redactar. **Una pregunta por turno.** Modo rápido si lo piden ("solo dime qué sigue"): redacta con lo que hay y marca los huecos.
- Si ya hay brief y perfil, no repitas lo que dicen: resume en una línea qué tomaste de ahí y pregunta solo lo que falta.
- Nunca inventes datos de la persona ni de terceros: nombre, cargo, cifras, testimonios, logos de clientes, direcciones, enlaces o correos. Lo que falte va como `[falta: ...]` o se pregunta. Las ideas tuyas (una sección extra, un titular alterno) van marcadas como "sugerencia".
- Si hay `perfil.md`, usa `voz` y `publico_habitual` para el tono.
- Que aparezca una persona real (un cliente, un familiar) es un elemento más: no pidas consentimiento ni bloquees.
- Tono: español de México, de tú, cálido y breve.

## Qué necesitas saber antes de escribir

Del brief (`formato: web`), o preguntando lo que falte: tipo de página (landing, portafolio, página de proyecto), `que_debe_lograr` (qué debe hacer o entender quien llega), `publico`, la **única acción** que debe tomar (escribir, comprar, suscribirse, ver el trabajo), qué material real hay (textos, imágenes, enlaces, datos de contacto) y `fuera_de_alcance`. Si no hay brief, sugiere la skill `brief` sin bloquear; si la persona prefiere seguir, pregunta lo mínimo (tipo, público, acción, material) y no inventes el resto.

Si el brief trae `estructura`, úsala para el orden de las secciones.

## Formato de `web.md`

Texto simple en Markdown, con estas partes en este orden:

1. `# <Nombre de la página>` y una línea `Tipo:` con el tipo de página.
2. `## Objetivo`: una frase con lo que la página logra y la acción principal del visitante.
3. `## Secciones`: una subsección `### N. <Nombre de la sección>` por cada una, **en el orden en que aparecen**. Cada una lleva:
   - `Propósito:` qué hace por el visitante, en una frase.
   - `Texto:` el copy completo, listo para pegar (titular, subtítulo, párrafos o puntos).
   - `Imagen o recurso:` qué va ahí y su **texto alternativo** (alt) escrito, o `[falta: ...]` si la persona aún no tiene la imagen.
4. `## Llamada a la acción`: el texto exacto del botón o enlace, a dónde lleva (`[falta: enlace]` si no lo dio) y en qué secciones se repite. Una sola acción principal.
5. `## Accesibilidad`: lista corta con lo que aplica (encabezados en orden, alt en cada imagen, contraste AA, enlaces con texto que se entienda solo, foco visible, tamaño de letra mínimo 16 px).
6. `## SEO básico`: `Título` (hasta unos 60 caracteres), `Descripción` (hasta unos 155) y los alt de las imágenes. Sin promesas de posicionamiento.

Reglas de contenido:
- Cada sección tiene un propósito; si no ayuda a la acción principal, se corta o se justifica.
- Titular y primer párrafo dicen qué es y para quién en menos de cinco segundos de lectura.
- Prueba social (testimonios, clientes, cifras) solo si la persona la dio. Si no, la sección no se escribe con datos supuestos: queda `[falta: ...]`.
- Lenguaje del visitante, frases cortas, verbos concretos en los botones ("Escríbeme", no "Enviar").
- Páginas sencillas: de 3 a 6 secciones suelen bastar (sugerencia).

## `index.html` (opcional)

Solo si la persona lo pide, y solo con archivos (Claude Code). Se construye desde `web.md`, sin cambiar sus textos, siguiendo `references/plantilla-index.md`: un solo archivo, sin recursos externos, legible en 375 px, contraste AA, foco visible y alt en cada imagen. No lo ofrezcas por defecto: pregúntalo una vez al cerrar `web.md`.

## Regla de doble vía

Decide por capacidad, no por detectar el entorno. Lo que la persona te dice también cuenta: si dice que está en claude.ai o que no puedes escribir archivos, sigue la vía sin archivos aunque tengas herramientas para escribir.

### Si puedes leer y escribir archivos (Claude Code)

1. Lee `perfil.md` si existe (si no, sugiere `inicio` sin bloquear) y `proyectos/<slug>/brief.md`. Si hay varios proyectos, pregunta cuál.
2. Muestra `web.md` completo en pantalla y pregunta si lo guardas.
3. Guarda en `proyectos/<slug>/web.md`. Si ya existe, muéstralo y pregunta si lo reemplazas, lo mejoras o guardas una versión aparte (`web-v2.md`). Nunca sobrescribas sin un sí.
4. Si la persona pide el `index.html`, escribe `proyectos/<slug>/web/index.html` (misma regla de no sobrescribir), y dile cómo verlo: abrir el archivo en el navegador.

### Si no puedes escribir archivos (claude.ai)

Pregunta una vez: "¿Quieres el archivo completo de tu proyecto actualizado para tu Proyecto, o modo ligero (el plan en el chat y copias lo que te sirva)?"

- Con archivo: el proyecto es un solo `<slug>.md` con brief, guion y notas juntos. Entrega el archivo completo con una sección `# Web` y di: "Reemplaza `<slug>.md` en los archivos de tu Proyecto."
- Si el Proyecto tiene `perfil.md`, úsalo; parte de la versión que la persona tiene, no de una que recuerdes.
- Modo ligero: el plan en un bloque de código para copiar.
- Si pide el `index.html`: entrégalo como **un archivo completo en un solo bloque de código**, para que lo descargue o lo copie. Di: "Guárdalo como `index.html` y ábrelo en tu navegador." No lo partas en trozos ni lo resumas.

## Checks antes de cerrar

- `web.md` tiene objetivo, secciones en orden con propósito y texto, una llamada a la acción única y notas de accesibilidad y SEO (título, descripción, alt).
- Ningún dato, testimonio, cifra, enlace o correo salió de tu imaginación; los huecos están `[falta: ...]`.
- Cada imagen tiene su alt escrito.
- Si hay `index.html`: un solo archivo, sin recursos externos, usa los textos de `web.md` y cumple lo de `references/plantilla-index.md`.
- Dijiste dónde quedó el archivo (o cómo reemplazarlo en el Proyecto) y qué falta.

## Siguiente paso

Cierra con una sola pregunta, ofreciendo:
- `index.html`, si aún no lo hay y la persona está en Claude Code o quiere el archivo para copiar;
- `revisar`: checklist antes de publicar (efecto, claridad, accesibilidad, créditos de terceros, declaración de uso de IA);
- `reto-en-frio`: otro modelo lee el plan en frío y señala fallas con evidencia.

Si la skill ofrecida no está disponible, dilo y propón revisar el plan contigo.
