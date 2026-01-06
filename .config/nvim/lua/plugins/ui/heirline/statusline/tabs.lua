local utils     = require("heirline.utils")
local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local if_active = require("plugins.ui.heirline.shared").if_active

local NAMES = {
  { "azathoth",       "aza" }, -- 1: The blind idiot god
  { "nyarlathotep",   "nya" }, -- 2: The crawling chaos
  { "cthulhu",        "cth" }, -- 3: The great dreamer
  { "yog-sothoth",    "yog" }, -- 4: The gate and key
  { "shub-niggurath", "shu" }, -- 5: The black goat
  { "dagon",          "dag" }, -- 6: The deep one
  { "hastur",         "has" }, -- 7: The yellow sign
  { "nodens",         "nod" }, -- 8: The sea lord
  { "arkham",         "ark" }, -- 9: The forbidden city
  { "madness",        "mad" }, -- 10+: Fallback
}

local NAMES_COUNT = #NAMES

return utils.make_tablist({
  Delimiter,

  {
    flexible = 1,

    hl = if_active({ bold = true }, { fg = "inactive_fg" }),

    init = function(self)
      local names = NAMES[math.min(self.tabnr, NAMES_COUNT)]

      self.long_name  = names[1]
      self.short_name = names[2]
    end,

    {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. ":" .. self.long_name .. " %T"
      end,
    },

    {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. ":" .. self.short_name .. " %T"
      end,
    },

    {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      end,
    },
  },
})
