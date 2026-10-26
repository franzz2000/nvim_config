return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          preview = {
            treesitter = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buscar buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Buscar ayuda" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Archivos recientes" })
    end,
  },
}
