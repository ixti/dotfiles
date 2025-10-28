return {
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "nvim-mini/mini.icons",
  },

  config = function()
    require("lualine").setup({
      options = {
        theme        = "auto",
        globalstatus = true,
      },

      tabline = {
        lualine_a = { "tabs" },
        lualine_b = {
          {
            "windows",

            filetype_names = {
              ["neo-tree"] = "NeoTree",
            },

            disabled_buftypes = {
              "quickfix",
              "prompt",
            },
          },
        },
        lualine_y = { "diff", "diagnostics" },
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
