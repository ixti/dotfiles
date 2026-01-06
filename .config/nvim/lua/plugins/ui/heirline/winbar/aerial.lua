local utils = require("heirline.utils")

local if_active = require("plugins.ui.heirline.shared").if_active

local Delimiter  = {
  provider     = " › ",
  hl           = { fg = "inactive_fg" },
}

-- local Truncation  = {
--   Delimiter,
--
--   {
--     provider = "…",
--     hl       = { fg = "inactive_fg" },
--   },
-- }

local Breadcrumb = {
  Delimiter,

  {
    provider = function(self)
      return self.icon .. " "
    end,

    hl = function(self)
      if self.is_active then
        return utils.get_highlight(self.icon_hl)
      else
        return { fg = "inactive_fg" }
      end
    end,
  },

  {
    provider = function(self)
      return self.symbol
    end,

    hl = if_active({ italic = true }, { italic = true, fg = "inactive_fg" }),
  },
}

-- Inspired by [AstroNvim](https://github.com/AstroNvim/astroui)
return {
  condition = function(self)
    return self.is_active and package.loaded["aerial"]
  end,

  init = function(self)
    self.locations        = require("aerial").get_location(true) or {}
    self.locations_count  = #self.locations
    self.aerial_highlight = require("aerial.highlight").get_highlight
  end,

  {
    condition = function(self)
      return self.locations_count > 0
    end,

    init = function(self)
      for i, loc in ipairs(self.locations) do
        local child = self[i]

        if not (child and child.symbol) then
          child   = self:new(Breadcrumb, i)
          self[i] = child
        end

        child.symbol    = loc.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "")
        child.icon      = loc.icon
        child.icon_hl   = self.aerial_highlight(loc, true, false)
      end

      -- Clean up any remaining children
      local self_count = #self
      if self_count > self.locations_count then
        for i = self.locations_count, self_count do
          self[i] = nil
        end
      end
    end,
  },
}
