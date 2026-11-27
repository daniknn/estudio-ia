# Guía para el `index.html` de un solo archivo

Se usa solo si la persona lo pidió. El HTML se construye desde `web.md` y no cambia sus textos. Todo va en un archivo: HTML, CSS y, si hace falta, un poco de JavaScript. Nada de recursos externos.

## Reglas

1. **HTML semántico.** `<header>`, `<nav>` (si hay más de una sección), `<main>`, `<section>` con su encabezado, `<footer>`. Un solo `<h1>`; los demás encabezados bajan en orden (`h2`, `h3`) sin saltarse niveles. Botones con `<button>` y enlaces con `<a>`.
2. **Cabecera del documento.** `<!doctype html>`, `<html lang="es-MX">`, `<meta charset="utf-8">`, `<meta name="viewport" content="width=device-width, initial-scale=1">`, `<title>` y `<meta name="description">` tomados de la sección SEO de `web.md`.
3. **CSS con variables.** Colores, espacios y tamaños en custom properties dentro de `:root`; el resto del CSS usa solo `var(--...)`. Un solo bloque `<style>` en el `<head>`.
4. **Tipografías del sistema.** `font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;`. No cargues fuentes ni hojas de estilo remotas.
5. **Sin recursos externos.** Nada de CDN, fuentes remotas, scripts de terceros, analíticas ni imágenes por URL. Las imágenes que la persona tenga se enlazan con ruta relativa (`imagenes/foto.jpg`) y se avisa que debe guardarlas junto al archivo; si no hay imágenes, usa bloques de color o SVG en línea.
6. **375 px primero.** Diseña para 375 px de ancho y amplía con `@media (min-width: 40rem)`. Sin scroll horizontal; contenido con `max-width` (unos `40rem` a `60rem`) y márgenes laterales de al menos `1rem`. Letra base de 16 px (`1rem`) o más, `line-height` de 1.5 o más.
7. **Contraste AA.** Texto normal con relación de contraste de al menos 4.5:1 contra su fondo; texto grande (24 px, o 19 px en negrita) y componentes de interfaz, 3:1. Verifica los pares de colores que elijas y dilo; si no puedes medirlos, usa texto oscuro sobre fondo claro (o al revés) con una diferencia grande.
8. **Texto alternativo.** Cada `<img>` lleva `alt` con el texto de `web.md`. Si es decorativa, `alt=""`. Un SVG con significado lleva `role="img"` y `aria-label`.
9. **Foco visible.** Nunca `outline: none` sin reemplazo. Define, por ejemplo, `:focus-visible { outline: 3px solid var(--foco); outline-offset: 2px; }` con un color que contraste con el fondo.
10. **Objetivos táctiles.** Botones y enlaces principales de al menos 44 por 44 px.
11. **Movimiento.** Si hay animaciones, respeta `@media (prefers-reduced-motion: reduce)`.
12. **Enlaces.** Texto que se entienda solo ("Ver el proyecto", no "clic aquí"). Los externos con `rel="noopener"`. Los enlaces y correos que la persona no dio quedan como `#` con un comentario `<!-- falta: enlace -->`; nunca inventes uno.
13. **Modo oscuro.** Opcional (sugerencia): redefine las variables bajo `@media (prefers-color-scheme: dark)` y vuelve a verificar el contraste.

## Esqueleto

```html
<!doctype html>
<html lang="es-MX">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Título de web.md</title>
  <meta name="description" content="Descripción de web.md">
  <style>
    :root {
      --fondo: #ffffff;
      --texto: #1a1a1a;
      --acento: #0b57d0;
      --sobre-acento: #ffffff;
      --foco: #b3261e;
      --espacio: 1rem;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      background: var(--fondo);
      color: var(--texto);
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
      font-size: 1rem;
      line-height: 1.6;
    }
    main, header, footer { max-width: 40rem; margin: 0 auto; padding: var(--espacio); }
    img { max-width: 100%; height: auto; }
    a { color: var(--acento); }
    .boton {
      display: inline-block;
      min-height: 44px;
      padding: 0.6rem 1.2rem;
      background: var(--acento);
      color: var(--sobre-acento);
      border-radius: 0.5rem;
      text-decoration: none;
    }
    :focus-visible { outline: 3px solid var(--foco); outline-offset: 2px; }
    @media (prefers-reduced-motion: reduce) { * { animation: none !important; transition: none !important; } }
  </style>
</head>
<body>
  <header>
    <h1>Titular de la primera sección</h1>
    <p>Subtítulo.</p>
    <a class="boton" href="#contacto">Texto del botón</a>
  </header>
  <main>
    <section aria-labelledby="s1">
      <h2 id="s1">Nombre de la sección</h2>
      <p>Texto de web.md.</p>
    </section>
  </main>
  <footer>
    <p>Datos de contacto que la persona dio.</p>
  </footer>
</body>
</html>
```

Los colores del esqueleto son un punto de partida: cámbialos por los de la persona y vuelve a verificar el contraste.

## Antes de entregar

- Abre el archivo en el navegador (Claude Code) o pide a la persona que lo haga, y revisa a 375 px de ancho.
- Recorre la página solo con el teclado (Tab): el foco se ve y el orden es lógico.
- Confirma que no hay `http://` ni `https://` en `src`, `href` de hojas de estilo o scripts. Los enlaces `<a>` que dio la persona sí pueden ser externos.
- Revisa que cada texto coincida con `web.md`.
