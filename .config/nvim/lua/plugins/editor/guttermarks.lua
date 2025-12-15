return {
  "dimtion/guttermarks.nvim",

  event = { "BufReadPost", "BufNewFile", "BufWritePre", "FileType" },

  opts = {},

  keys = {
    {
      "m;",
      function() require("guttermarks.actions").delete_mark() end,
      mode = "n",
      desc = "Delete mark under cursor (guttermarks)",
    }
  },
}
