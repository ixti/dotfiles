return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("ruby_lsp", {
      capabilities = capabilities,

      init_options = {
        enabledFeatures = { diagnostics = false }, -- Disable RuboCop diagnostics
        formatter       = "auto",
      },

      settings = {
        rubyLsp = {
          excludePattern = {
            "tmp/.*",
            "log/.*",
            "node_modules/.*",
            "vendor/.*",
          },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      },
    })

    vim.lsp.enable("ruby_lsp")

    for _, server in ipairs({ "rubocop", "gopls", "stimulus_ls", "ts_ls", "vacuum" }) do
      vim.lsp.config(server, { capabilities = capabilities })
      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group    = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local keymap = vim.keymap.set

        local function opts(overrides)
          return vim.tbl_extend(
            "force",
            { noremap = true, silent = true, buffer = event.buf },
            overrides or {}
          )
        end

        keymap("n", "K",          vim.lsp.buf.hover,       opts({ desc = "Preview (LSP)" }))
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts({ desc = "Code Actions (LSP)" }))

        keymap("n", "<C-]>",
          function() Snacks.picker.lsp_definitions() end,
          opts({ desc = "Goto Definition (snacks.nvim)" })
        )
      end,
    })
  end,
}
