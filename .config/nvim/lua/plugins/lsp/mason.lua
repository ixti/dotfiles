return {
  {
    "mason-org/mason.nvim",

    build = ":MasonUpdate",
    opts  = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",

    dependencies = {
      "mason-org/mason.nvim",
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
    end,
  },
}
