return {
  "folke/tokyonight.nvim",

  lazy     = false,
  priority = 1000,

  opts = {
    style        = "night", -- "storm", "night", "moon", "day"
    styles       = { keywords  = { italic = false } },
    sidebars     = { "qf", "help", "neo-tree", "terminal" },
    lualine_bold = true,
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
