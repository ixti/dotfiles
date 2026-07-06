local TOGGLE = "<Leader>o"

return {
  "stevearc/oil.nvim",

  -- Optional dependencies
  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },

  -- Lazy loading is not recommended because it is very tricky to make it work
  -- correctly in all situations.
  lazy = false,

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<CR>"]      = "actions.select",
      ["<BS>"]      = "actions.parent",
      ["<C-s>"]     = { "actions.select", opts = { horizontal = true }, desc = "Open split below" },
      ["<C-v>"]     = { "actions.select", opts = { vertical = true }, desc = "Open split right" },
      ["<Leader>o"] = { "actions.close", desc = "Close Oil" },
    },
  },

  keys = {
    {
      "<Leader>o",
      function()
        local current_file = vim.api.nvim_buf_get_name(0)

        if current_file ~= "" and vim.uv.fs_stat(current_file) then
          require("oil").open(vim.fs.dirname(current_file))
        else
          require("oil").open()
        end
      end,
      desc = "Open File Explorer (Oil)",
    }
  },
}
