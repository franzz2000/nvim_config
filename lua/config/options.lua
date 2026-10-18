-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- Números de línea
opt.number = true
opt.relativenumber = true

-- Indentación
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Búsqueda
opt.ignorecase = true
opt.smartcase = true

-- Apariencia
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Comportamiento
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.updatetime = 250

-- Portapapeles (ajusta según tu sistema)
opt.clipboard = "unnamedplus"


-- Atajos
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float(nil, {
    scope = "line",
    focusable = true,
  })
end, { desc = "Mostrar error de la línea" })
