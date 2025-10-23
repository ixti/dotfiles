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
        position = { row = "95%", col = "50%" },
      }
    }
  },
}
