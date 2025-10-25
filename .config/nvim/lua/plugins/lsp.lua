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
          local opts   = { noremap = true, silent = true, buffer = event.buf }
          local keymap = vim.keymap.set

          keymap("n", "<C-w>[",     vim.lsp.buf.hover,  opts)
          keymap("n", "<leader>//", vim.lsp.buf.rename, opts)
        end,
      })

      -- Enable servers
      vim.lsp.enable(servers)
    end,
  },
}
