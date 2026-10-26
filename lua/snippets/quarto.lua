-- Snippets para documentos Quarto (.qmd) con LuaSnip.
-- Expansion: Ctrl+K; saltos: Ctrl+L / Ctrl+H (segun lsp.lua).
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.add_snippets('quarto', {
  s('rchunk', {
    t({ '```{r}', '#| label: ' }), i(1, 'codigo-r'),
    t({ '', '#| echo: false', '', '' }), i(2),
    t({ '', '```' }),
  }),
  s('pychunk', {
    t({ '```{python}', '#| label: ' }), i(1, 'codigo-python'),
    t({ '', '#| echo: false', '', '' }), i(2),
    t({ '', '```' }),
  }),
  s('slide', { t('## '), i(1, 'Titulo de la diapositiva') }),
  s('cols', {
    t({ ':::: {.columns}', '::: {.column width="50%"}', '' }), i(1, 'Columna izquierda'),
    t({ '', ':::', '::: {.column width="50%"}', '' }), i(2, 'Columna derecha'),
    t({ '', ':::', '::::' }),
  }),
  s('nota', {
    t({ '::: {.notes}', '' }), i(1, 'Notas del presentador'), t({ '', ':::' }),
  }),
  s('fig', {
    t('!['), i(1, 'Descripcion de la imagen'), t(']('), i(2, 'imagen.png'),
    t('){fig-alt="'), i(3, 'Texto alternativo'), t('" width="'), i(4, '80%'), t('"}'),
  }),
  s('callout', {
    t('::: {.callout-'), c(1, { t('note'), t('tip'), t('important'), t('warning'), t('caution') }),
    t('}'), t({ '', '## ' }), i(2, 'Titulo'), t({ '', '' }), i(3, 'Contenido'), t({ '', ':::' }),
  }),
  s('tabset', {
    t({ '::: {.panel-tabset}', '## ' }), i(1, 'Pestana 1'), t({ '', '' }), i(2, 'Contenido 1'),
    t({ '', '## ' }), i(3, 'Pestana 2'), t({ '', '' }), i(4, 'Contenido 2'), t({ '', ':::' }),
  }),
  s('tbl', {
    t('| '), i(1, 'Columna 1'), t(' | '), i(2, 'Columna 2'),
    t({ ' |', '| --- | --- |', '| ' }), i(3, 'Dato 1'), t(' | '), i(4, 'Dato 2'), t(' |'),
  }),
  s('reveal', {
    t({ '---', 'title: "' }), i(1, 'Titulo de la presentacion'),
    t({ '"', 'format:', '  revealjs:', '    theme: ' }), i(2, 'simple'),
    t({ '', '    slide-number: true', '    transition: slide', 'execute:', '  echo: false', '---', '' }),
  }),
  s('yaml', {
    t({ '---', 'title: "' }), i(1, 'Titulo del documento'),
    t({ '"', 'format: ' }), c(2, { t('html'), t('pdf'), t('docx') }),
    t({ '', '---', '' }),
  }),
  s('pause', { t('. . .') }),
  s('fragment', {
    t('::: {.fragment}'), t({ '', '' }), i(1, 'Contenido que aparece progresivamente'), t({ '', ':::' }),
  }),
  s('center', {
    t('::: {.center}'), t({ '', '' }), i(1, 'Contenido centrado'), t({ '', ':::' }),
  }),
})
