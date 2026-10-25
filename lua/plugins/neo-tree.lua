return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,

        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },

        window = {
          position = "left",
          width = 32,
        },
      })
    end,

    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle<CR>",
        desc = "Mostrar/ocultar explorador",
      },
      {
        "<leader>bf",
        "<cmd>Neotree buffers reveal float<CR>",
        desc = "Explorar buffers",
      },
      {
        "<leader>gs",
        "<cmd>Neotree git_status<CR>",
        desc = "Estado de Git",
      },
    },
  },
}
