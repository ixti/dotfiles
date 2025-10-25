return {
  "nvim-neo-tree/neo-tree.nvim",

  lazy   = false, -- neo-tree will lazily load itself
  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
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

  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    close_if_last_window  = true,
    popup_border_style    = "rounded",
    sort_case_insensitive = true,
    filesystem            = { use_libuv_file_watcher = true },

    window = {
      position = "left",
      width    = "25%",
    },
  },
}
