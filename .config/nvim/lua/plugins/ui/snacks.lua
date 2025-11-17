return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy     = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
  },

  keys = {
    {
      "<leader>e",
      function ()
        Snacks.picker.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
  },

  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
