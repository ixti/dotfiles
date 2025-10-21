return {
  -- Linting (replaces ALE)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        ruby = { "rubocop" },
        go = { "golangcilint" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
      }

      local group = vim.api.nvim_create_augroup("lint_auto", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = group,
        callback = function() lint.try_lint() end,
      })

      vim.keymap.set("n", "<leader>l", function() lint.try_lint() end, { desc = "Lint current file" })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        ruby            = { "rubocop" },
        go              = { "gofmt", "goimports" },
        typescript      = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        javascript      = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 1000,
      },
    },
  },

  -- Linter/formatter installation via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "rubocop",
        "golangci-lint",
        "eslint_d",
        "prettierd",
        "gofmt",
        "goimports",
      })
    end,
  },
}
