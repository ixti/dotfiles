-- TODO
return {
  "stevearc/oil.nvim",

  lazy = false,

  dependencies = {
    "nvim-mini/mini.icons",
    "refractalize/oil-git-status.nvim",
  },

  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden   = true,
      natural_order = true,
    },
    win_options = {
      signcolumn = "yes:2",
    },
  },

  keys = {
    { "<Leader>o", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },

  config = function(_, opts)
    require("oil").setup(opts)
    require("oil-git-status").setup({
      show_ignored = true,
      symbols = {
        index = {
          ["A"] = "A", -- added to index
          ["M"] = "M", -- modified in index
          ["D"] = "D", -- deleted from index
          ["R"] = "R", -- renamed in index
          ["?"] = "?", -- untracked
        },
        working_tree = {
          ["M"] = "M", -- modified working tree
          ["D"] = "D", -- deleted working tree
          ["?"] = "?",
        },
      },
    })
  end,
}
