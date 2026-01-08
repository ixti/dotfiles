return {
  "lewis6991/gitsigns.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },

  event = { "VeryLazy" },

  config = function(_, opts)
    require("gitsigns").setup(opts)

    vim.api.nvim_create_user_command(
      "GitBlame",
      "Gitsigns blame",
      {
        desc  = "Show Git blame (gitsigns.nvim)",
        range = true,
      }
    )
  end,
}
