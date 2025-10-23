return {
  "stevearc/oil.nvim",

  lazy     = false,
  priority = 900,

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
      signcolumn  = "yes:2",
      colorcolumn = "",
    },

    float = {
      padding       = 2,
      max_width     = 0.6,
      max_height    = 0.4,
      border        = "rounded",

      win_options = {
        winblend      = 10,
        colorcolumn   = "",
      },
    },

    keymaps = {
      ["<CR>"] = "actions.select",
      ["q"]    = "actions.close",
      ["t"]    = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
      ["s"]    = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
      ["S"]    = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
    },
  },

  keys = {
    { "<Leader>o", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },

  config = function(_, opts)
    local oil = require("oil")

    oil.setup(opts)
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

    -- Start Oil upon start with no file given
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if "" == vim.fn.expand("%") then
          vim.schedule(oil.open)
        end
      end,
    })

    -- Start Oil on empty tab
    vim.api.nvim_create_autocmd("TabNewEntered", {
      callback = function()
        if "" == vim.bo.buftype and "" == vim.api.nvim_buf_get_name(0) then
          vim.schedule(oil.open)
        end
      end,
    })
  end,
}
