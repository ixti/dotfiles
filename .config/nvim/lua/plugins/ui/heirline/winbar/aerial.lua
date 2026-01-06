local utils = require("heirline.utils")

local if_active = require("plugins.ui.heirline.shared").if_active

local unpack = table.unpack or unpack

local MAX_BREADCRUMBS = 5

local INACTIVE_HL            = { fg = "inactive_fg" }
local BREADCRUMB_ACTIVE_HL   = { italic = true }
local BREADCRUMB_INACTIVE_HL = vim.tbl_extend("force", { italic = true }, INACTIVE_HL)

local TRUNCATIONS = { "…", "…2…", "…3…", "…4…", "…5…", "…6…", "…7…", "…8…", "…9…", "…9+…" }

local FullyCollapsed = { provider = "" }
local TrailDelimiter = { provider = " › ", hl = INACTIVE_HL }

local function new_truncation(omitted_count)
  return {
    TrailDelimiter,
    {
      provider = TRUNCATIONS[math.max(1, math.min(omitted_count, 10))],
      hl       = INACTIVE_HL,
    },
  }
end

local function new_breadcrumb(location, aerial_highlight)
  return {
    static = {
      symbol  = location.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
      icon    = location.icon,
      icon_hl = utils.get_highlight(aerial_highlight(location, true, false)),
    },

    TrailDelimiter,

    {
      provider = function(self) return (self.icon .. " ") end,
      hl = function(self)
        if self.is_active then
          return self.icon_hl
        else
          return INACTIVE_HL
        end
      end,
    },

    {
      provider = function(self) return self.symbol end,
      hl       = if_active(BREADCRUMB_ACTIVE_HL, BREADCRUMB_INACTIVE_HL),
    },
  }
end

-- Inspired by [AstroNvim](https://github.com/AstroNvim/astroui)
return {
  flexible  = 1,

  condition = function(self)
    return self.is_active and package.loaded["aerial"]
  end,

  init = function(self)
    local locations        = require("aerial").get_location(true) or {}
    local locations_count  = #locations
    local childs_count     = 0

    local aerial_highlight = require("aerial.highlight").get_highlight

    if locations_count > 0 then
      local omitted_count = math.max(0, locations_count - MAX_BREADCRUMBS)
      local trail         = { new_breadcrumb(locations[1], aerial_highlight) }

      if omitted_count == 0 then
        for _, loc in ipairs({ unpack(locations, 2) }) do
          table.insert(trail, new_breadcrumb(loc, aerial_highlight))
        end
      else
        local offset  = locations_count - (MAX_BREADCRUMBS - 2) + 1

        -- Bump omitted_count because the truncation marker occupies a slot in
        -- the trail, thus actual tail will have at most MAX_BREADCRUMBS - 2
        -- elements.
        omitted_count = omitted_count + 1

        table.insert(trail, new_truncation(omitted_count))

        for _, loc in ipairs({ unpack(locations, offset) }) do
          table.insert(trail, new_breadcrumb(loc, aerial_highlight))
        end
      end

      -- Add longest possible trail:
      -- [a, b, c, d, e]       ==> [a, b, c, d, e]
      -- [a, b, c, d, e, f]    ==> [a, (2), d, e, f]
      -- [a, b, c, d, e, f, g] ==> [a, (3), e, f, g]
      childs_count       = childs_count + 1
      self[childs_count] = self:new(trail, childs_count)

      local trail_size = #trail

      -- Add collapsed trails, collapsed at second element until theres only
      -- first, truncation, and last element left:
      -- [a, b, c, d, e]
      -- ==> [a, (1), c, d, e]
      -- ==> [a, (2), d, e]
      -- ==> [a, (3), e]
      -- [a, (2), d, e, f]
      -- ==> [a, (3), e, f]
      -- ==> [a, (4), f]
      for i = 3, (trail_size - 1) do
        childs_count  = childs_count + 1
        omitted_count = omitted_count + 1

        self[childs_count] = self:new(
          {
            trail[1],
            new_truncation(omitted_count),
            unpack(trail, i),
          },
          childs_count
        )
      end

      -- similar to the previous, BUT, instead leaves `truncation, last`
      -- [a, b, c, d, e]    ==> [(4), e]
      -- [a, b, c, d, e, f] ==> [(5), f]
      if #trail > 1 then
        childs_count       = childs_count + 1
        self[childs_count] = self:new(
          {
            new_truncation(locations_count - 1),
            trail[#trail]
          },
          childs_count
        )
      end

      childs_count = childs_count + 1
      self[childs_count] = self:new(FullyCollapsed, childs_count)
    end

    local self_count = #self
    if self_count > childs_count then
      for i = childs_count + 1, self_count do
        self[i] = nil
      end
    end
  end,
}
