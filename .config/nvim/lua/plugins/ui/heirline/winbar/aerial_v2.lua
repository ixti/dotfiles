local breadcrumbs = require("util.heirline.breadcrumbs")

local M = {}

local Slot = {
  init = function(self)
    self.is_visible      = false
    self.truncation_mark = ""
    self.symbol_name     = ""
    self.symbol_icon     = ""
    self.symbol_icon_hl  = {}

    local trail_data = self.trails_data[self.trail_index]
    if not trail_data then return end

    local slot_data = trail_data[self.slot_index]
    if not slot_data then return end

    if slot_data.is_location then
      self.is_visible      = true
      self.symbol_name     = slot_data.symbol_name
      self.symbol_icon     = slot_data.symbol_icon
      self.symbol_icon_hl  = slot_data.symbol_icon_hl
    elseif slot_data.is_truncation then
      self.is_visible      = true
      self.truncation_mark = breadcrumbs.get_truncation_mark(slot_data.omitted_count)
    end
  end,

  { -- Delimiter
    hl       = { fg = "inactive_fg" },
    provider = function(self)
      return self.is_visible and " › " or ""
    end
  },

  { -- Truncation
    hl       = { fg = "inactive_fg" },
    provider = function(self) return self.truncation_mark end,
  },

  { -- Symbol Icon
    hl       = function(self) return self.symbol_icon_hl end,
    provider = function(self) return self.symbol_icon end,
  },

  { -- Symbol Name
    hl       = { italic = true },
    provider = function(self) return self.symbol_name end,
  },
}

-- NOTE: Known issue - max_trail_size < 3 rendered incorrectly, but as
--       personally I give zero ducks about that for now I'm limiting
--       min allowed max_trail_size to be 3 to avoid any WTF moments.
function M.new(max_trail_size)
  max_trail_size = type(max_trail_size) == "number" and math.max(max_trail_size, 3) or 5

  local function new_breadcrumb(location)
    return {
      is_location    = true,
      symbol_name    = location.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
      symbol_icon    = location.icon,
      symbol_icon_hl = breadcrumbs.get_icon_highlight(location),
    }
  end

  local function new_truncation(omitted_count)
    return {
      is_truncation = true,
      omitted_count = omitted_count,
    }
  end

  local component = {
    flexible  = 1,
    update    = "CursorMoved",

    condition = function(self)
      return self.is_active and package.loaded["aerial"]
    end,

    init      = function(self)
      local locations = breadcrumbs.get_locations()
      local signature = breadcrumbs.get_locations_signature(locations)

      if self.last_signature == signature then
        return
      end

      local trails_data      = {}
      local locations_count  = #locations

      if locations_count > 0 then
        local omitted_count = math.max(0, locations_count - max_trail_size)
        local trail         = { new_breadcrumb(locations[1]) }

        if omitted_count == 0 then
          for i = 2, locations_count do
            table.insert(trail, new_breadcrumb(locations[i]))
          end
        else
          -- If locations count exceeds max_trail_size, we will take first
          -- location, and as many last max_trail_size - 2 slots (first slot
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
        table.insert(trails_data, trail)

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

          table.insert(trails_data, { trail[1], new_truncation(omitted_count), unpack(trail, i) })
        end

        -- similar to the previous, BUT, instead leaves `truncation, last`
        -- [a, b, c, d, e]    ==> [(4), e]
        -- [a, b, c, d, e, f] ==> [(5), f]
        if trail_size > 1 then
          table.insert(trails_data, { new_truncation(locations_count - 1), trail[trail_size] })
        end
      end

      self.trails_data    = trails_data
      self.last_signature = signature
    end,
  }

  local trail_index = 1
  for trail_size = max_trail_size, 1, -1 do
    local trail = { static = { trail_index = trail_index } }

    for slot_index = 1, trail_size do
      table.insert(trail, { static = { slot_index = slot_index }, Slot })
    end

    table.insert(component, trail)
    trail_index = trail_index + 1
  end

  table.insert(component, { provider = "" })

  return component
end

return M
