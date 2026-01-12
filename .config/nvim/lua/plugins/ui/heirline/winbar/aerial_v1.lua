local breadcrumbs = require("util.heirline.breadcrumbs")

local unpack = table.unpack or unpack

local INACTIVE_HL    = { fg = "inactive_fg" }
local BREADCRUMB_HL  = { italic = true }

local FullyCollapsed = { provider = "" }
local TrailDelimiter = { provider = " › ", hl = INACTIVE_HL }

local function new_truncation(omitted_count)
  return {
    TrailDelimiter,

    {
      provider = breadcrumbs.get_truncation_mark(omitted_count),
      hl       = INACTIVE_HL,
    },
  }
end

local function new_breadcrumb(location)
  local symbol_name    = location.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "")
  local symbol_icon    = location.icon
  local symbol_icon_hl = breadcrumbs.get_icon_highlight(location)

  return {
    TrailDelimiter,

    {
      provider = symbol_icon .. " ",
      hl       = symbol_icon_hl,
    },

    {
      provider = symbol_name,
      hl       = BREADCRUMB_HL,
    },
  }
end

local function new_evicatble(child)
  return {
    static    = { is_evicted = false },
    condition = function(self) return not self.is_evicted end,
    child,
  }
end

local M = {}

-- NOTE: Known issue - max_trail_size < 3 rendered incorrectly, but as
--       personally I give zero ducks about that for now I'm limiting
--       min allowed max_trail_size to be 3 to avoid any WTF moments.
function M.new(max_trail_size)
  max_trail_size = type(max_trail_size) == "number" and math.max(max_trail_size, 1) or 5

  return {
    flexible  = 1,

    condition = function(self)
      return self.is_active and package.loaded["aerial"]
    end,

    update = "CursorMoved",

    -- Inspired by [AstroNvim](https://github.com/AstroNvim/astroui)
    init = function(self)
      local locations = breadcrumbs.get_locations()
      local signature = breadcrumbs.get_locations_signature(locations)

      if self.last_signature == signature then
        return
      end

      self.last_signature    = signature

      local locations_count  = #locations
      local child_index      = 1

      local function add_child(child)
        self[child_index]            = self:new(new_evicatble(child), child_index)
        self[child_index].is_evicted = false
        child_index                  = child_index + 1
      end

      if locations_count > 0 then
        local omitted_count = math.max(0, locations_count - max_trail_size)
        local trail         = { new_breadcrumb(locations[1]) }

        if omitted_count == 0 then
          for i = 2, locations_count do
            table.insert(trail, new_breadcrumb(locations[i]))
          end
        else
          -- If locations count exceeds MAX_BREADCRUMBS, we will take first
          -- location, and as many last MAX_BREADCRUMBS - 2 slots (first slot
          -- is occupied by the first element, and second by the truncation
          -- placeholder.
          local offset  = locations_count - (max_trail_size - 2) + 1

          -- Bump omitted_count because the truncation marker occupies a slot in
          -- the trail, thus actual tail will have at most MAX_BREADCRUMBS - 2
          -- elements.
          omitted_count = omitted_count + 1

          table.insert(trail, new_truncation(omitted_count))

          for i = offset, locations_count do
            table.insert(trail, new_breadcrumb(locations[i]))
          end
        end

        -- Add longest possible trail:
        -- [a, b, c, d, e]       ==> [a, b, c, d, e]
        -- [a, b, c, d, e, f]    ==> [a, (2), d, e, f]
        -- [a, b, c, d, e, f, g] ==> [a, (3), e, f, g]
        add_child(trail)

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
          omitted_count = omitted_count + 1

          add_child({ trail[1], new_truncation(omitted_count), unpack(trail, i) })
        end

        -- similar to the previous, BUT, instead leaves `truncation, last`
        -- [a, b, c, d, e]    ==> [(4), e]
        -- [a, b, c, d, e, f] ==> [(5), f]
        if trail_size > 1 then
          add_child({ new_truncation(locations_count - 1), trail[trail_size] })
        end

        add_child(FullyCollapsed)
      end

      local self_count = #self
      if self_count > child_index then
        for i = child_index, self_count do
          self[i].is_evicted = true
          self[i]            = nil
        end
      end
    end,
  }
end

return M
