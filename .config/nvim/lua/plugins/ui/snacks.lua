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
        require("snacks.picker").explorer({
          cwd = require("utils.fs").git_root_or_cwd()
        })
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        require("snacks.picker").smart({
          cwd = require("utils.fs").git_root_or_cwd()
        })
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks.picker").grep({
          cwd = require("utils.fs").git_root_or_cwd()
        })
      end,
      desc = "Grep",
    },
  },

  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
