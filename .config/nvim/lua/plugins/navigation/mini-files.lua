return {
  "nvim-mini/mini.files",

  version = false,

  dependencies = {
    "nvim-mini/mini.icons",
  },

  opts = {
    options = {
      permanent_delete = false,
    },
  },

  keys = {
    {
      "<leader>e",
      function() require("mini.files").open() end,
      desc = "File Crawler (mini.files)",
    },
  },

  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}
