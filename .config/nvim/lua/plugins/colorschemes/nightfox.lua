return {
  "EdenEast/nightfox.nvim",

  lazy     = false,
  priority = 1000,
  compile  = true,

  build    = ":NightfoxCompile",

  opts = {
    dim_inactive = true,

    options = {
      styles = {
        comments = "italic",
      },
    },

    specs = {
      all = {
        syntax = {
          number   = "orange.bright",
          operator = "pink.bright",
        },
      },
    },

    groups = {
      all = {
        Special                        = { fg = "palette.pink" },
        Whitespace                     = { fg = "palette.bg4" },
        MiniFilesCursorLine            = { link = "PmenuSel" },
        SnacksPickerCursorLine         = { link = "PmenuSel" },
        SnacksPickerDir                = { fg = "palette.cyan.dim" },
        SnacksPickerTotals             = { fg = "palette.pink.dim" },
        SnacksPickerGitStatusUntracked = { fg = "palette.black" },
        WinBar                         = { link = "StatusLine" },
        WinBarNC                       = { link = "StatusLineNC" },
      },
    },
  },

  config = function(_, opts)
    require("nightfox").setup(
      vim.tbl_deep_extend(
        "force",
        {
          palettes = {
            nightfox = require("util.nightfox.palettes.flexoki.dark"),
          },
        },
        opts
      )
    )
  end,
}
