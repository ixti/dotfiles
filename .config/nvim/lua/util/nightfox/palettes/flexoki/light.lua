local Shade  = require("nightfox.lib.shade")
local COLORS = require("util.nightfox.palettes.flexoki.colors")

local function accent_shades_of(accent)
  local base   = COLORS[accent .. "_600"]
  local bright = COLORS[accent .. "_400"]
  local dim    = COLORS[accent .. "_800"]

  return Shade.new(base, bright, dim, true)
end

-- POC: white/black shades are messed up
return {
  black   = Shade.new(COLORS.black, COLORS.base_950, -0.10, true),
  white   = Shade.new(COLORS.base_600, COLORS.base_500,  COLORS.base_700, true),

  red     = accent_shades_of("red"),
  green   = accent_shades_of("green"),
  yellow  = accent_shades_of("yellow"),
  blue    = accent_shades_of("blue"),
  magenta = accent_shades_of("purple"),
  cyan    = accent_shades_of("cyan"),
  orange  = accent_shades_of("orange"),
  pink    = accent_shades_of("blue"),

  comment = COLORS.paper:blend(COLORS.black, 0.4):to_css(),

  bg0     = COLORS.base_100:to_css(),                          -- (status line and float)
  bg1     = COLORS.paper:to_css(),                             -- Default bg
  bg2     = COLORS.paper:blend(COLORS.base_300, 0.4):to_css(), -- Lighter bg (colorcolm folds)
  bg3     = COLORS.paper:blend(COLORS.base_300, 0.6):to_css(), -- Lighter bg (cursor line)
  bg4     = COLORS.paper:blend(COLORS.base_300, 0.8):to_css(), -- Conceal, border fg

  fg0     = COLORS.base_950:to_css(), -- Lighter fg
  fg1     = COLORS.black:to_css(),    -- Default fg
  fg2     = COLORS.base_950:to_css(), -- Lighter fg (status line)
  fg3     = COLORS.base_850:to_css(), -- Lighter fg (line numbers, fold colums)

  sel0    = COLORS.paper:blend(COLORS.base_400, 0.6):to_css(), -- Popup bg, visual selection bg
  sel1    = COLORS.paper:blend(COLORS.base_400, 0.8):to_css(), -- Popup sel bg, search bg
}
