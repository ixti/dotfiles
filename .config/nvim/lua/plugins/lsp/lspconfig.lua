return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- *** Config Overrides ****************************************************

    vim.lsp.config("ruby_lsp", {
      cmd = { "bundle", "exec", "ruby-lsp" },

      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },

        enabledFeatures = {
          diagnostics = false, -- Disable RuboCop diagnostics
        },

        excludedGems = {
          "rubocop",
        },

        excludedPatterns = {
          "tmp/**",
          "log/**",
          "spec/**",
          "**/node_modules/**",
          "**/vendor/**",
        },
      },
    })

    vim.lsp.config("rubocop", {
      cmd = { "bundle", "exec", "rubocop", "--lsp" },
    })

    -- *** Enabled LSP Servers *************************************************

    local enabled_servers = {
      "gopls",
      "rubocop",
      "ruby_lsp",
      "stimulus_ls",
      "ts_ls",
      "vacuum",
    }

    for _, server in ipairs(enabled_servers) do
      vim.lsp.config(server, { capabilities = capabilities })
      vim.lsp.enable(server)
    end

    -- *** Key Mappings ********************************************************

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

        keymap("n", "<leader>rn",
          function() require("live-rename").rename() end,
          opts({ desc = "LSP Rename (live-rename.nvim)" })
        )
      end,
    })
  end,
}
