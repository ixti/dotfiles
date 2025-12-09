  -- Carbon Colors: https://github.com/carbon-design-system/carbon/blob/23b45775a598847baaea6fccc0c57cd770c1081c/packages/colors/src/colors.js
  -- red10        #fff1f1  |  magenta10    #fff0f7  |  purple10     #f6f2ff  |  blue10       #edf5ff
  -- red20        #ffd7d9  |  magenta20    #ffd6e8  |  purple20     #e8daff  |  blue20       #d0e2ff
  -- red30        #ffb3b8  |  magenta30    #ffafd2  |  purple30     #d4bbff  |  blue30       #a6c8ff
  -- red40        #ff8389  |  magenta40    #ff7eb6  |  purple40     #be95ff  |  blue40       #78a9ff
  -- red50        #fa4d56  |  magenta50    #ee5396  |  purple50     #a56eff  |  blue50       #4589ff
  -- red60        #da1e28  |  magenta60    #d02670  |  purple60     #8a3ffc  |  blue60       #0f62fe
  -- red70        #a2191f  |  magenta70    #9f1853  |  purple70     #6929c4  |  blue70       #0043ce
  -- red80        #750e13  |  magenta80    #740937  |  purple80     #491d8b  |  blue80       #002d9c
  -- red90        #520408  |  magenta90    #510224  |  purple90     #31135e  |  blue90       #001d6c
  -- red100       #2d0709  |  magenta100   #2a0a18  |  purple100    #1c0f30  |  blue100      #001141
  --
  -- teal10       #d9fbfb  |  green10      #defbe6  |  yellow10     #fcf4d6  |  orange10     #fff2e8
  -- teal20       #9ef0f0  |  green20      #a7f0ba  |  yellow20     #fddc69  |  orange20     #ffd9be
  -- teal30       #3ddbd9  |  green30      #6fdc8c  |  yellow30     #f1c21b  |  orange30     #ffb784
  -- teal40       #08bdba  |  green40      #42be65  |  yellow40     #d2a106  |  orange40     #ff832b
  -- teal50       #009d9a  |  green50      #24a148  |  yellow50     #b28600  |  orange50     #eb6200
  -- teal60       #007d79  |  green60      #198038  |  yellow60     #8e6a00  |  orange60     #ba4e00
  -- teal70       #005d5d  |  green70      #0e6027  |  yellow70     #684e00  |  orange70     #8a3800
  -- teal80       #004144  |  green80      #044317  |  yellow80     #483700  |  orange80     #5e2900
  -- teal90       #022b30  |  green90      #022d0d  |  yellow90     #302400  |  orange90     #3e1a00
  -- teal100      #081a1c  |  green100     #071908  |  yellow100    #1c1500  |  orange100    #231000
  --
  -- warmGray10   #f7f3f2  |  gray10       #f4f4f4
  -- warmGray20   #e5e0df  |  gray20       #e0e0e0
  -- warmGray30   #cac5c4  |  gray30       #c6c6c6
  -- warmGray40   #ada8a8  |  gray40       #a8a8a8
  -- warmGray50   #8f8b8b  |  gray50       #8d8d8d
  -- warmGray60   #726e6e  |  gray60       #6f6f6f
  -- warmGray70   #565151  |  gray70       #525252
  -- warmGray80   #3c3838  |  gray80       #393939
  -- warmGray90   #272525  |  gray90       #262626
  -- warmGray100  #171414  |  gray100      #161616

-- Customized palette, as the upstream uses cyan for yellow and pink o_O
-- See: https://github.com/EdenEast/nightfox.nvim/pull/487
-- Generate kitty theme:
--   lua print(require("nightfox.extra.kitty").generate(require("nightfox.spec").load()["carbonfox"]))
local function generate_carbon_palette()
  local C     = require("nightfox.lib.color")
  local Shade = require("nightfox.lib.shade")

  local bg = C("#171414") -- warmGray100
  local fg = C("#cac5c4") -- warmGray30

  -- Carbon Colors: https://github.com/carbon-design-system/carbon/blob/23b45775a598847baaea6fccc0c57cd770c1081c/packages/colors/src/colors.js
  -- red10        #fff1f1  |  magenta10    #fff0f7  |  purple10     #f6f2ff  |  blue10       #edf5ff
  -- red20        #ffd7d9  |  magenta20    #ffd6e8  |  purple20     #e8daff  |  blue20       #d0e2ff
  -- red30        #ffb3b8  |  magenta30    #ffafd2  |  purple30     #d4bbff  |  blue30       #a6c8ff
  -- red40        #ff8389  |  magenta40    #ff7eb6  |  purple40     #be95ff  |  blue40       #78a9ff
  -- red50        #fa4d56  |  magenta50    #ee5396  |  purple50     #a56eff  |  blue50       #4589ff
  -- red60        #da1e28  |  magenta60    #d02670  |  purple60     #8a3ffc  |  blue60       #0f62fe
  -- red70        #a2191f  |  magenta70    #9f1853  |  purple70     #6929c4  |  blue70       #0043ce
  -- red80        #750e13  |  magenta80    #740937  |  purple80     #491d8b  |  blue80       #002d9c
  -- red90        #520408  |  magenta90    #510224  |  purple90     #31135e  |  blue90       #001d6c
  -- red100       #2d0709  |  magenta100   #2a0a18  |  purple100    #1c0f30  |  blue100      #001141
  --
  -- teal10       #d9fbfb  |  green10      #defbe6  |  yellow10     #fcf4d6  |  orange10     #fff2e8
  -- teal20       #9ef0f0  |  green20      #a7f0ba  |  yellow20     #fddc69  |  orange20     #ffd9be
  -- teal30       #3ddbd9  |  green30      #6fdc8c  |  yellow30     #f1c21b  |  orange30     #ffb784
  -- teal40       #08bdba  |  green40      #42be65  |  yellow40     #d2a106  |  orange40     #ff832b
  -- teal50       #009d9a  |  green50      #24a148  |  yellow50     #b28600  |  orange50     #eb6200
  -- teal60       #007d79  |  green60      #198038  |  yellow60     #8e6a00  |  orange60     #ba4e00
  -- teal70       #005d5d  |  green70      #0e6027  |  yellow70     #684e00  |  orange70     #8a3800
  -- teal80       #004144  |  green80      #044317  |  yellow80     #483700  |  orange80     #5e2900
  -- teal90       #022b30  |  green90      #022d0d  |  yellow90     #302400  |  orange90     #3e1a00
  -- teal100      #081a1c  |  green100     #071908  |  yellow100    #1c1500  |  orange100    #231000
  --
  -- warmGray10   #f7f3f2  |  gray10       #f4f4f4
  -- warmGray20   #e5e0df  |  gray20       #e0e0e0
  -- warmGray30   #cac5c4  |  gray30       #c6c6c6
  -- warmGray40   #ada8a8  |  gray40       #a8a8a8
  -- warmGray50   #8f8b8b  |  gray50       #8d8d8d
  -- warmGray60   #726e6e  |  gray60       #6f6f6f
  -- warmGray70   #565151  |  gray70       #525252
  -- warmGray80   #3c3838  |  gray80       #393939
  -- warmGray90   #272525  |  gray90       #262626
  -- warmGray100  #171414  |  gray100      #161616

  return {
    black   = Shade.new("#3c3838", "#565151", "#272525"), -- warmGray 80, 70, 90
    red     = Shade.new("#da1e28", "#fa4d56", "#a2191f"), -- red      60, 50, 70
    green   = Shade.new("#24a148", "#6fdc8c", "#0e6027"), -- green    50, 40, 70
    yellow  = Shade.new("#b28600", "#f1c21b", "#684e00"), -- yellow   40, 30, 70
    blue    = Shade.new("#4589ff", "#78a9ff", "#0043ce"), -- blue     50, 40, 70
    magenta = Shade.new("#a56eff", "#be95ff", "#6929c4"), -- purple   50, 40, 70
    cyan    = Shade.new("#009d9a", "#08bdba", "#005d5d"), -- teal     50, 40, 70
    white   = Shade.new("#cac5c4", "#f7f3f2", "#8f8b8b"), -- warmGray 30, 10, 50
    orange  = Shade.new("#eb6200", "#ff832b", "#8a3800"), -- orange   50, 40, 70
    pink    = Shade.new("#ee5396", "#ff7eb6", "#9f1853"), -- magenta  50, 40, 70

    comment = bg:blend(fg, 0.4):to_css(),

    bg0     = bg:brighten(-4):to_css(), -- Dark bg (status line and float)
    bg1     = bg:to_css(), -- Default bg
    bg2     = bg:brighten(6):to_css(), -- Lighter bg (colorcolm folds)
    bg3     = bg:brighten(12):to_css(), -- Lighter bg (cursor line)
    bg4     = bg:brighten(24):to_css(), -- Conceal, border fg

    fg0     = fg:brighten(6):to_css(), -- Lighter fg
    fg1     = fg:to_css(), -- Default fg
    fg2     = fg:brighten(-24):to_css(), -- Darker fg (status line)
    fg3     = fg:brighten(-48):to_css(), -- Darker fg (line numbers, fold colums)

    sel0    = "#262626", -- gray90 -- Popup bg, visual selection bg
    sel1    = "#393939", -- gray80 -- Popup sel bg, search bg
  }
end

-- local function generate_flexoki_dark_palette()
--   local C     = require("nightfox.lib.color")
--   local Shade = require("nightfox.lib.shade")
--
--   local bg = C("#1C1B1A")
--   local fg = C("#878580")
--
--   return {
--     black   = Shade.new("#100F0F", 0.15, -0.15),
--     red     = Shade.new("#D14D41", 0.15, -0.15),
--     green   = Shade.new("#879A39", 0.15, -0.15),
--     yellow  = Shade.new("#D0A215", 0.15, -0.15),
--     blue    = Shade.new("#4385BE", 0.15, -0.15),
--     magenta = Shade.new("#8B7EC8", 0.15, -0.15),
--     cyan    = Shade.new("#3AA99F", 0.15, -0.15),
--     white   = Shade.new("#CECDC3", 0.15, -0.15),
--     orange  = Shade.new("#DA702C", 0.15, -0.15),
--     pink    = Shade.new("#CE5D97", 0.15, -0.15),
--
--     comment = bg:blend(fg, 0.4):to_css(),
--
--     bg0     = bg:brighten(-4):to_css(),
--     bg1     = bg:to_css(),
--     bg2     = bg:brighten(6):to_css(),
--     bg3     = bg:brighten(12):to_css(),
--     bg4     = bg:brighten(24):to_css(),
--
--     fg0     = fg:brighten(6):to_css(),
--     fg1     = fg:to_css(),
--     fg2     = fg:brighten(-24):to_css(),
--     fg3     = fg:brighten(-48):to_css(),
--
--     sel0    = "#282726",
--     sel1    = "#343331",
--   }
-- end

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
    local palettes = { carbonfox = generate_carbon_palette() }

    require("nightfox").setup(vim.tbl_deep_extend("force", { palettes = palettes }, opts))
  end,
}
