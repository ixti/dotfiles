return {
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-mini/mini.icons",
  },

  event = "UiEnter",

  config = function()
    require("lualine").setup({
      options           = {
        theme        = "auto",
        globalstatus = true,
      },

      inactive_sections = {},

      tabline = {
        lualine_a = { { "tabs", mode = 0 }},
        lualine_b = { "filename" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "diagnostics" },
        lualine_z = { { "lsp_status", symbols = { separator = "  " } } },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {},
        lualine_z = { "progress", "location" },
      },
    })

    -- Disable tabline completely, using winbar instead,
    -- vim.opt.showtabline = 0
  end,
}
