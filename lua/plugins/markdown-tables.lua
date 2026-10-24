return {
  {
    "Kicamon/markdown-table-mode.nvim",
    ft = { "markdown", "quarto" },
    config = function()
      require("markdown-table-mode").setup({
        filetype = { "*.md", "*.qmd" },
        options = {
          insert = true,
          insert_leave = true,
          pad_separator_line = false,
          alig_style = "default",
        },
      })
    end,
  },
}
