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

      -- DO NOT INSTALL:
      -- * ruby_lsp -- Managing ruby-lsp globally is road to the most unpleasant
      --               places of the universe; See `lspconfig.lua` for config
      --               overrides, and simply add `ruby-lsp` to the Gemfile of
      --               the project (using `bundle exec ruby-lsp`). In future,
      --               I might add `bin/ruby-lsp` wrapper instead to execute it
      --               via Bundler or globally.
      -- * rubocop  -- Should use `bundle exec rubocop` of the project
      ensure_installed = {
        "gopls",
        "stimulus_ls",
        "ts_ls",
        "vacuum",
      },
    },

    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
}
