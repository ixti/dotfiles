return {
  "folke/noice.nvim",

  event = "VeryLazy",

  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },

  opts = {
    cmdline = {
      opts = {
        position = { row = "90%", col = "50%" },
      }
    }
  },
}
