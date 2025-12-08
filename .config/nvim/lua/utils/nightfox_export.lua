local M = {}

local VARIANTS = {
  "carbonfox",
  "dawnfox",
  "dayfox",
  "duskfox",
  "nightfox",
  "nordfox",
  "terafox",
}

local FIXED_COLORS = {
  "bg0", "bg1", "bg2", "bg3", "bg4",
  "fg0", "fg1", "fg2", "fg3",
  "sel0", "sel1",
  "comment",
}

local VARIABLE_COLORS = {
  "black",
  "blue",
  "cyan",
  "green",
  "magenta",
  "orange",
  "pink",
  "red",
  "white",
  "yellow",
}

function M.dump_palettes()
  local lines = {}

  local function p(line) table.insert(lines, line) end

  for _, variant in ipairs(VARIANTS) do
    p("--- # " .. variant)

    local palette = require("nightfox.palette." .. variant).palette 

    for _, k in ipairs(FIXED_COLORS) do
      p(k .. ": \"" .. palette[k] .. "\"")
    end

    for _, k in ipairs(VARIABLE_COLORS) do
      local c = palette[k]

      p(k .. ".base: \"" .. c["base"] .. "\"")
      p(k .. ".bright: \"" .. c["bright"] .. "\"")
      p(k .. ".dim: \"" .. c["dim"] .. "\"")
    end

    p("...")
    p("")
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end

return M
