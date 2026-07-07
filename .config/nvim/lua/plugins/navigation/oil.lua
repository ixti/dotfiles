return {
  "stevearc/oil.nvim",

  -- Optional dependencies
  dependencies = {
    "nvim-mini/mini.icons",
  },

  -- Lazy loading is not recommended because it is very tricky to make it work
  -- correctly in all situations.
  lazy = false,

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      "icon",
    },

    win_options = {
      signcolumn = "yes",
    },

    keymaps = {
      ["<CR>"]      = "actions.select",
      ["<BS>"]      = "actions.parent",
      ["<C-s>"]     = { "actions.select", opts = { horizontal = true }, desc = "Open split below" },
      ["<C-v>"]     = { "actions.select", opts = { vertical = true }, desc = "Open split right" },
      ["<Leader>o"] = { "actions.close", desc = "Close Oil" },
      ["q"]         = { "actions.close", desc = "Close Oil" },
    },

    view_options = {
      show_hidden = true,
    },
  },

  keys = {
    {
      "<Leader>o",
      function()
        local current_file = vim.api.nvim_buf_get_name(0)

        if current_file ~= "" and vim.uv.fs_stat(current_file) then
          require("oil").open_float(vim.fs.dirname(current_file))
        else
          require("oil").open_float()
        end
      end,
      desc = "Open File Explorer (Oil)",
    },
  },
}
