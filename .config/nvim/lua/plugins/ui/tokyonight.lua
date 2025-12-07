return {
  "folke/tokyonight.nvim",

  lazy     = false,
  priority = 1000,
  version  = false,

  opts = {
    style        = "night", -- "storm", "night", "moon", "day"
    sidebars     = { "qf", "help", "neo-tree", "terminal" },
    lualine_bold = true,

    styles = {
      keywords = { italic = false },
      floats   = "transparent",
    },
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)

    vim.cmd.colorscheme("tokyonight")
  end,
}
