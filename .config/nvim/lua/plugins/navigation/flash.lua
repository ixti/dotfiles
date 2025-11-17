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
}
