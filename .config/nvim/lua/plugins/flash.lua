return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = { enabled = false },

      -- f, F, t, T enhancements
      char = {
        enabled     = true,
        jump_labels = true,
        autohide    = true,
      },
    },

    -- Global behavior
    jump = {
      autojump  = false,
      inclusive = false,
    },

    highlight = {
      backdrop = true,
      matches = true,
      priority = 5000,
      rainbow = {
        enabled = true,
        shade = 5,
      },
      groups = {
        match = "FlashMatch",
        current = "FlashCurrent",
        label = "FlashLabel",
        backdrop = "FlashBackdrop",
      },
    },

    prompt = {
      enabled = true,
      prefix = { { "⚡", "FlashPromptIcon" } },
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
