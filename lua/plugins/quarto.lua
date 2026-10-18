-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",

    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },

    config = function()
      require("quarto").setup({
        lspFeatures = {
          elabled = true,
          languages = {"r", "python", "bash", "yaml"},
          chunks = "curly",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost"},
          },
          completion = {
            enabled = true,
          }
        }
      })

      local preview_job = nil

      local function quarto_brave()
        if vim.fn.expand("%:e") ~= "qmd" then
          vim.notify("Abre primero un archivo .qmd", vim.log.levels.WARN)
          return
        end

        vim.cmd("write")

        local archivo = vim.fn.expand("%:p")
        local directorio = vim.fn.expand("%:p:h")
        local navegador_abierto = false

        -- Cerrar la vista previa anterior iniciada por este comando
        if preview_job then
          vim.fn.jobstop(preview_job)
          preview_job = nil
        end

        local function procesar_salida(data)
          for _, linea in ipairs(data or {}) do
            local url = linea:match("https?://localhost:%d+/?")
              or linea:match("https?://127%.0%.0%.1:%d+/?")

            if url and not navegador_abierto then
              navegador_abierto = true

              vim.schedule(function()
                vim.fn.jobstart({
                  "open",
                  "-a",
                  "Brave Browser",
                  url,
                })
                vim.notify("Quarto abierto en Brave: " .. url)
              end)
            end
          end
        end

        preview_job = vim.fn.jobstart({
          "quarto",
          "preview",
          archivo,
          "--no-browser",
        }, {
          cwd = directorio,
          stdout_buffered = false,
          stderr_buffered = false,
          on_stdout = function(_, data)
            procesar_salida(data)
          end,
          on_stderr = function(_, data)
            procesar_salida(data)
          end,
          on_exit = function()
            preview_job = nil
          end,
        })

        if preview_job <= 0 then
          vim.notify("No se pudo iniciar Quarto", vim.log.levels.ERROR)
          preview_job = nil
        end
      end

      -- Comando para abrir Quarto en Brave
      vim.api.nvim_create_user_command(
        "QuartoBrave",
        quarto_brave,
        {}
      )

      -- Atajo habitual: Espacio + q + p
      vim.keymap.set("n", "<leader>qp", quarto_brave, {
        desc = "Quarto: Vista previa en Brave",
        silent = true,
      })
    end,
  },
}
