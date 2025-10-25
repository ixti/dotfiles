local servers = {
  "gopls",
  "ruby_lsp",
  "rubocop",
  "ts_ls",
  "vacuum",
}

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
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      automatic_enable = false,
      ensure_installed = servers,
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

      -- Enable servers
      vim.lsp.enable(servers)
    end,
  },
}
