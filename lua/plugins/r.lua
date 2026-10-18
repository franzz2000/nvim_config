return {
  {
    "R-nvim/R.nvim",
    ft = {"r", "rmd", "quarto"},
    lazy = false,
    config = function()
      require("r").setup({
        R_args = { "--no-save", "--quiet" },
        hook = {
          on_filetype = function()
            vim.opt_local.colorcolumn = "80"
            vim.keymap.set("n", "<leader>rf", "<Plugin>RStart")
            vim.keymap.set("n", "<leader>rq", "<Plugin>RClose")
          end,
        },
        min_editor_width = 72,
        rconsole_width = 78,
        objbr_place = "script,right",
      })
    end,
  },
}

