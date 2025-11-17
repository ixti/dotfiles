return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy     = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
  },

  opts = {
    indent       = { enabled = true },
    explorer     = { enabled = true, replace_netrw = true, trash = true },
    notifier     = { enabled = true, timeout = 3000 },
    statuscolumn = { enabled = true },
  },

  keys = {
    { "<leader>e",  function () Snacks.explorer.reveal() end, desc = "File Explorer" },
    { "<leader>ff", function() Snacks.picker.smart() end,     desc = "Smart Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end,   desc = "Find buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end,      desc = "Grep" },
  },
}
