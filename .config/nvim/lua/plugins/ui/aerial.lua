return {
  "stevearc/aerial.nvim",

  dependencies = {
     "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    keymaps = {
      ["<leader>a"] = "actions.close",
    },
  },

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
      "<CMD>AerialOpen<CR>",
      desc = "Open or jump to Aerial window (aerial.nvim)",
    },
  },
}
