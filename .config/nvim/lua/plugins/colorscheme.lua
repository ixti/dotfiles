-- STABLE
return {
  "folke/tokyonight.nvim",
  lazy     = false,
  priority = 1000,

  opts = {
    style           = "night", -- "storm", "night", "moon", "day"
    transparent     = false,
    terminal_colors = true,

    styles = {
      comments  = { italic = true },
      keywords  = { italic = false },
      functions = { bold = true },
      variables = {},
      sidebars  = "dark",
      floats    = "dark",
    },
    sidebars     = { "qf", "help", "neo-tree", "terminal" },
    lualine_bold = true,
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
