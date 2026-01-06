return {
  "stevearc/aerial.nvim",

  dependencies = {
     "nvim-treesitter/nvim-treesitter",
  },

  opts = {},

  keys = {
    {
      "<leader>fa",
      function()
        require("aerial").snacks_picker()
      end,
      desc = "Aerial picker (aerial.nvim + snacks.nvim)",
    },
    {
      "<leader>a",
      "<CMD>AerialToggle<CR>",
      desc = "Aerial window (aerial.nvim)",
    },
  },
}
