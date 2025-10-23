return {
  "folke/flash.nvim",

  event = "VeryLazy",

  opts = {
    label  = {
      before  = true,  -- (default: false)
      after   = false, -- (default: true)

      -- Can be useful for visualizing Treesitter ranges.
      rainbow = {
        enabled = true, -- (default: false)
        shade   = 8,    -- number between 1 and 9 (default: 5)
      },
    },

    prompt = {
      enabled = false, -- (default: true)
    },
  },

  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },

  config = function(_, opts)
    require("flash").setup(opts)

    -- Enhanced highlights for readability
    vim.api.nvim_set_hl(0, "FlashMatch",   { fg = "#c0caf5", bg = "#394b70", bold = true })
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#1a1b26", bg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "FlashLabel",   { fg = "#f7768e", bg = "#1c1c1c", bold = true })
  end,
}
