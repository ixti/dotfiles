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
          number = "orange.bright",
        },
      },
    },

    groups = {
      all = {
        Special = { fg = "palette.pink.dim" },
      },
    },
  },

  config = function(_, opts)
    local Shade = require("nightfox.lib.shade")

    local palettes = {
      -- See: https://github.com/EdenEast/nightfox.nvim/issues/486
      carbonfox = {
        black   = Shade.new("#282828", 0.15, -0.15),
        green   = Shade.new("#42be65", 0.15, -0.15), -- upstream: #25be6a
        yellow  = Shade.new("#d2a106", 0.15, -0.15), -- upstream: #08BDBA
        blue    = Shade.new("#78a9ff", 0.15, -0.15), -- upstream: #78A9FF
        magenta = Shade.new("#ff7eb6", 0.15, -0.15), -- upstream: #BE95FF
        cyan    = Shade.new("#33b1ff", 0.15, -0.15), -- upstream: #33B1FF

        red     = Shade.new("#fa4d56", 0.15, -0.15), -- upstream: #EE5396 | Carbon 50, alt Carbon 40 (ff8389)
        pink    = Shade.new("#e71e8c", 0.15, -0.15), -- upstream: #FF7EB6 | Carbon 50, alt Carbon 40 (ff7eb6)
        orange  = Shade.new("#eb6200", 0.15, -0.15), -- upstream: #3DDBD9 | Carbon 50, alt Carbon 40 (ff832b)
      }
    }

    require("nightfox").setup(vim.tbl_deep_extend("force", { palettes = palettes }, opts))
  end,
}
