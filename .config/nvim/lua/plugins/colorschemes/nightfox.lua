return {
  "EdenEast/nightfox.nvim",

  lazy     = false,
  priority = 1000,

  opts = {
    options = {
      styles = {
        comments = "italic",
      },
    },

    specs = {
      all = {
        syntax = {
          number = "orange.dim.bright",
        },
      },
    },

    groups = {
      all = {
        Special = { fg = "palette.orange.dim" },
      },
    },
  },
}
