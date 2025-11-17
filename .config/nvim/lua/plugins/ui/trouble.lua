return {
  "folke/trouble.nvim",

  branch = "main",
  cmd    = "Trouble",

  dependencies = {
    "folke/noice.nvim",
  },

  opts = {
    mode                 = "document_diagnostics",
    auto_open            = false,
    auto_close           = true,
    auto_preview         = false,
    use_diagnostic_signs = true,
  },

  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
     desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },

  config = function(_, opts)
    require("trouble").setup(opts)
  end,
}
