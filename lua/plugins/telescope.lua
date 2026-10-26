return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      local builtin = require("telescope.builtin")

      -- Atajos existentes
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buscar buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Buscar ayuda" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Archivos recientes" })

      -- Buscador de snippets
      local function buscar_snippets()
        local ls = require("luasnip")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local ft = vim.bo.filetype
        local snippets = ls.get_snippets(ft) or {}
        local resultados = {}

        for _, snippet in ipairs(snippets) do
          local trigger = snippet.trigger or ""
          local descripcion = snippet.name or snippet.dscr or ""

          if type(descripcion) == "table" then
            descripcion = table.concat(descripcion, " ")
          end

          table.insert(resultados, {
            trigger = trigger,
            descripcion = descripcion,
          })
        end

        if #resultados == 0 then
          vim.notify(
            "No hay snippets para " .. ft,
            vim.log.levels.INFO
          )
          return
        end

        pickers.new({}, {
          prompt_title = "Snippets: " .. ft,

          finder = finders.new_table({
            results = resultados,

            entry_maker = function(entry)
              return {
                value = entry,
                display = entry.trigger .. "  —  " .. entry.descripcion,
                ordinal = entry.trigger .. " " .. entry.descripcion,
              }
            end,
          }),

          sorter = conf.generic_sorter({}),

          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local seleccion = action_state.get_selected_entry()
              actions.close(prompt_bufnr)

              if seleccion then
                vim.api.nvim_put(
                  { seleccion.value.trigger },
                  "c",
                  true,
                  true
                )
              end
            end)

            return true
          end,
        }):find()
      end

      vim.keymap.set(
        "n",
        "<leader>fs",
        buscar_snippets,
        { desc = "Buscar snippets" }
      )
    end,
  },
}
