return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  cmd = "Neotree",

  keys = {
    {
      "<leader>e",
      "<cmd>Neotree toggle<CR>",
      desc = "Toggle Neotree",
    },
    {
      "<leader>E",
      "<cmd>Neotree reveal filesystem left<CR>",
      desc = "Reveal current file in Neotree",
    },
  },

  deactivate = function()
    vim.cmd([[Neotree close]])
  end,

  opts = {
    enable_git_status     = true,
    enable_diagnostics    = true,
    sort_case_insensitive = true,
    close_if_last_window  = true,
    popup_border_style    = "rounded",

    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        default = "",
      },
      modified = { symbol = "[+]" },
      git_status = {
        symbols = {
          added    = "",
          modified = "",
          deleted  = "✖",
          renamed  = "➜",
          untracked = "?",
          ignored  = "",
          unstaged = "",
          staged   = "",
          conflict = "",
        },
      },
    },

    filesystem = {
      window = {
        position = "left",
        width = 34,
      },
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { "node_modules", ".git", ".DS_Store" },
      },
      follow_current_file = { enabled = true, leave_dirs_open = false },
      use_libuv_file_watcher = true,
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_default",
    },

    buffers = {
      follow_current_file = { enabled = true },
      group_empty_dirs = true,
      show_unloaded = true,
    },

    git_status = {
      async = true,
      window = { position = "float" },
    },
  },
}
