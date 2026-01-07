return {
  "dimtion/guttermarks.nvim",

  event = { "BufReadPost", "BufNewFile", "BufWritePre", "FileType" },

  opts = {},

  keys = {
    {
      "m<bs>",
      function() require("guttermarks.actions").delete_mark() end,
      mode = "n",
      desc = "Delete mark under cursor (guttermarks)",
    },
    {
      "m<tab>",
      function() require("guttermarks.actions").next_buf_mark() end,
      mode = "n",
      desc = "Next buffer mark (guttermarks)",
    },
    {
      "m<s-tab>",
      function() require("guttermarks.actions").prev_buf_mark() end,
      mode = "n",
      desc = "Previous buffer mark (guttermarks)",
    },
  },
}
