return {
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-mini/mini.icons",
  },

  config = function()
    -- Lualine with `diff` causes gitsigns to be force-killed that leaves git index lock:
    -- * https://github.com/nvim-lualine/lualine.nvim/issues/1096
    -- ** https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict

      if gitsigns then
        return {
          added    = gitsigns.added,
          modified = gitsigns.changed,
          removed  = gitsigns.removed,
        }
      end
    end

    require("lualine").setup({
      options = {
        theme        = "auto",
        globalstatus = true,
      },

      tabline = {
        lualine_a = { { "tabs", mode = 2 } },
        lualine_y = {
          { "diff", source = diff_source },
          "diagnostics",
        },
        lualine_z = { "branch" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
