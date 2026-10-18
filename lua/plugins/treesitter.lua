return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",  -- ← Añadir esta línea
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Cambiar configs a config
      require("nvim-treesitter.config").setup({})  -- Si no hay configuración especial, pasar tabla vacía

      -- La nueva versión requiere instalar los parsers explícitamente
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc",
        "javascript", "typescript", "tsx",
        "python", "markdown", "markdown_inline",
        "json", "yaml", "bash",
        "html", "css",
      })

          -- Habilitar highlighting a través de autocmd (la nueva versión ya no se habilita automáticamente mediante highlight.enable)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx",
          "python", "markdown", "markdown_inline",
          "json", "yaml", "bash",
          "html", "css",
        },
        callback = function()
          vim.treesitter.start()  -- Habilitar highlighting
        end,
      })
    end,
},
}

