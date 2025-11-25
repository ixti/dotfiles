return {
  "chrisgrieser/nvim-origami",

  event = "VeryLazy",
  opts  = {}, -- needed even when using default config

  init = function()
    -- disable vim's auto-folding
    vim.opt.foldlevel      = 99
    vim.opt.foldlevelstart = 99
  end,

  config = function(_, opts)
    require("origami").setup(opts)
  end,
}
