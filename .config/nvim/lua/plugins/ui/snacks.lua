local git_root_or_cwd = require("utils.fs").git_root_or_cwd

return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy     = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
  },

  keys = {
    {
      "<leader>e",
      function ()
        Snacks.picker.explorer({ cwd = git_root_or_cwd() })
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.smart({ cwd = git_root_or_cwd() })
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ cwd = require("utils.fs").git_root_or_cwd() })
      end,
      desc = "Grep",
    },
  },

  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
