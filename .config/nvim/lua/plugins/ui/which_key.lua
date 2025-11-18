return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-mini/mini.icons",
  },

  opts = {
    preset = "modern",
  },

  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
