return {
  {
    "mason-org/mason.nvim",

    build = ":MasonUpdate",
    opts  = {},
  },

  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "mason-org/mason-lspconfig.nvim",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      automatic_enable = false,
      ensure_installed = {
        "gopls",
        "ruby_lsp",
        "rubocop",
        "ts_ls",
        "vacuum",
      },
    },

    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Keybindings on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, {
            noremap = true,
            silent  = true,
            buffer  = event.buf,
          })
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs(opts.ensure_installed) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      vim.lsp.config("ruby_lsp", {
        settings = {
          rubyLsp = {
            excludePattern = {
              "tmp/.*",
              "log/.*",
              "node_modules/.*",
              "vendor/.*",
            },
          },
        },
      })

      -- Enable servers
      vim.lsp.enable(opts.ensure_installed)
    end,
  },
}
