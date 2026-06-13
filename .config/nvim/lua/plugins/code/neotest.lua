return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",

    "volodya-lombrozo/neotest-ruby-minitest",
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-ruby-minitest")({
          command = "bundle exec ruby -Ilib:test",
        }),
      },
    })
  end,
}
