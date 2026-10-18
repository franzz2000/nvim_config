-- ~/.config/nvim/init.lua

-- Configurar leader antes de cargar lazy para asegurar que los atajos de teclado funcionen
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Configuración del navetgador para que abre Brave Browser en lugar de Safari
vim.env.BROWSER = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

-- Cargar opciones del editor
require("config.options")

-- Inicializar lazy.nvim y plugins
require("config.lazy")
