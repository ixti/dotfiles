return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "volodya-lombrozo/neotest-ruby-minitest",
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-ruby-minitest")({
          command = "bundle exec ruby -Itest",
        }),
      },
    })
  end,
}
