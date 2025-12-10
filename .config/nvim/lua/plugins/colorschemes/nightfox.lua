return {
  "EdenEast/nightfox.nvim",

  lazy     = false,
  priority = 1000,
  compile  = false,

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
        Special = { fg = "palette.pink" },
      },
    },
  },

  config = function(_, opts)
    require("nightfox").setup(
      vim.tbl_deep_extend(
        "force",
        {
          palettes = {
            dayfox   = require("util.nightfox.palettes.flexoki.light"),
            nightfox = require("util.nightfox.palettes.flexoki.dark"),
          },
        },
        opts
      )
    )
  end,
}
