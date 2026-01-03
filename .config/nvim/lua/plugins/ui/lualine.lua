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

      tabline = {},

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "tabs", mode = 0 } },
        lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
        lualine_y = {},
        lualine_z = { "progress", "location" },
      },
    })
  end,
}
