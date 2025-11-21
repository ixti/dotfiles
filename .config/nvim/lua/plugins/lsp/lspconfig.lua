return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("ruby_lsp", {
      capabilities = capabilities,

      init_options = {
        enabledFeatures = {
          diagnostics = false, -- Disable RuboCop diagnostics
        },
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
      callback = function(event)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {
          noremap = true,
          silent  = true,
          buffer  = event.buf,
        })
      end,
    })
  end,
}
