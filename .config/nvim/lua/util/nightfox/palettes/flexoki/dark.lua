local Shade  = require("nightfox.lib.shade")
local COLORS = require("util.nightfox.palettes.flexoki.colors")

local function accent_shades_of(accent)
  local base   = COLORS[accent .. "_400"]
  local bright = COLORS[accent .. "_200"]
  local dim    = COLORS[accent .. "_600"]

  return Shade.new(base, bright, dim)
end

return {
  black   = Shade.new(COLORS.base_700, COLORS.base_600, COLORS.base_800),
  white   = Shade.new(COLORS.base_200, COLORS.base_50,  COLORS.base_500),

  red     = accent_shades_of("red"),
  green   = accent_shades_of("green"),
  yellow  = accent_shades_of("yellow"),
  blue    = accent_shades_of("blue"),
  magenta = accent_shades_of("purple"),
  cyan    = accent_shades_of("cyan"),
  orange  = accent_shades_of("orange"),
  pink    = accent_shades_of("magenta"),

  comment = COLORS.black:blend(COLORS.base_200, 0.3):to_css(),

  bg0     = COLORS.base_950:to_css(),                          -- (status line and float)
  bg1     = COLORS.black:to_css(),                             -- Default bg
  bg2     = COLORS.black:blend(COLORS.base_950, 0.4):to_css(), -- Lighter bg (colorcolm folds)
  bg3     = COLORS.black:blend(COLORS.base_950, 0.6):to_css(), -- Lighter bg (cursor line)
  bg4     = COLORS.black:blend(COLORS.base_950, 0.8):to_css(), -- Conceal, border fg

  fg0     = COLORS.base_150:to_css(), -- Lighter fg
  fg1     = COLORS.base_200:to_css(), -- Default fg
  fg2     = COLORS.base_300:to_css(), -- Darker fg (status line)
  fg3     = COLORS.base_400:to_css(), -- Darker fg (line numbers, fold colums)

  sel0    = COLORS.black:blend(COLORS.base_850, 0.6):to_css(), -- Popup bg, visual selection bg
  sel1    = COLORS.black:blend(COLORS.base_850, 0.8):to_css(), -- Popup sel bg, search bg
}
