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

    vim.lsp.config("rubocop", {
      capabilities = capabilities,
    })

    vim.lsp.enable("rubocop")

    for _, server in ipairs({ "gopls", "ts_ls", "vacuum" }) do
      vim.lsp.config(server, { capabilities = capabilities })
      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr  = args.buf

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      end,
    })
  end,
}
