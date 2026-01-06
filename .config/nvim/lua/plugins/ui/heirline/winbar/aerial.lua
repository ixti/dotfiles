local utils = require("heirline.utils")

local MAX_DEPTH = 2

local Delimiter  = {
  is_delimiter = true,
  provider     = " › ",
  hl           = { fg = "inactive_fg" },
}

local Truncation  = {
  is_truncation = true,
  provider      = "…",
  hl            = { fg = "inactive_fg" },
}

local Breadcrumb = {
  {
    provider = function(self)
      return self.icon .. " "
    end,

    hl = function(self)
      return self.is_active and self.icon_hl or { fg = "inactive_fg" }
    end,
  },

  {
    provider = function(self)
      return self.symbol
    end,

    hl = function(self)
      return self.is_active and self.symbol_hl or { fg = "inactive_fg" }
    end,
  },
}

return {
  condition = function()
    -- Shamelessly stolen from https://github.com/AstroNvim/astroui/blob/4943abbd42674b43249313afe83b91065a40e4be/lua/astroui/status/condition.lua#L169
    return package.loaded["aerial"]
  end,

  {
    init = function(self)
      local aeral_highlight = require("aerial.highlight").get_highlight
      local locations       = require("aerial").get_location(true) or {}
      local start_idx       = #locations - MAX_DEPTH
      local child_idx       = 1

      if start_idx > 0 then
        local delimiter = self[child_idx]

        if not (delimiter and delimiter.is_delimiter) then
          self[child_idx] = self:new(Delimiter, child_idx)
        end

        child_idx = child_idx + 1

        local truncation = self[child_idx]

        if not (truncation and truncation.is_truncation) then
          self[child_idx] = self:new(Truncation, child_idx)
        end

        child_idx = child_idx + 1
      end

      for i, loc in ipairs(locations) do
        if i > start_idx and loc.name then
          local delimiter = self[child_idx]

          if not (delimiter and delimiter.is_delimiter) then
            self[child_idx] = self:new(Delimiter, child_idx)
          end

          child_idx = child_idx + 1

          local child = self[child_idx]

          if not (child and child.symbol) then
            child           = self:new(Breadcrumb, child_idx)
            self[child_idx] = child
          end

          child.symbol    = loc.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "")
          child.symbol_hl = utils.get_highlight(aeral_highlight(loc, false, false))
          child.icon      = loc.icon
          child.icon_hl   = utils.get_highlight(aeral_highlight(loc, true, false))

          child_idx = child_idx + 1
        end
      end

      -- Clean up any remaining children
      local self_count = #self
      if self_count > child_idx - 1 then
        for i = child_idx, self_count do
          self[i] = nil
        end
      end
    end,
  },
}
