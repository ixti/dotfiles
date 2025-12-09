return {
  "gbprod/yanky.nvim",

  dependencies = {
    "kkharji/sqlite.lua",
    "folke/snacks.nvim",
  },

  opts = {
    preserve_cursor_position = {
      enabled = true,
    },

    highlight = {
      on_put  = true,
      on_yank = false,
    },

    ring = {
      storage = "sqlite",
    },
  },

  keys = {
    {
      "<leader>p",
      function()
        Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History (snacks.nvim)",
    },

    { "y",  "<Plug>(YankyYank)",       mode = { "n", "x" }, desc = "Enhanced yank (yanky)" },

    { "p",  "<Plug>(YankyPutAfter)",   mode = { "n", "x" }, desc = "Put below (yanky)" },
    { "P",  "<Plug>(YankyPutBefore)",  mode = { "n", "x" }, desc = "Put above (yanky)" },

    { "gp", "<Plug>(YankyGPutAfter)",  mode = { "n", "x" }, desc = "Put below and move cursor (yanky)" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put above and move cursor (yanky)" },
  },
}
