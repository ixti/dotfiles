local utils = require("heirline.utils")

local unpack = table.unpack or unpack

local MAX_BREADCRUMBS = 5

local INACTIVE_HL      = { fg = "inactive_fg" }
local BREADCRUMB_HL    = { italic = true }
local TRUNCATION_MARKS = { "…", "…2…", "…3…", "…4…", "…5…", "…6…", "…7…", "…8…", "…9…", "…9+…" }
local SIG_SEPARATOR    = "\n"
local SIG_UNKNOWN      = "\0"

local FullyCollapsed = { provider = "" }
local TrailDelimiter = { provider = " › ", hl = INACTIVE_HL }

local function get_locations()
  local locations = nil

  xpcall(
    function()
      locations = require("aerial").get_location(true)
    end,
    function(err)
      vim.notify(
        "Failed to get Aerial locations: " .. tostring(err),
        vim.log.levels.WARN,
        { once = true }
      )
    end
  )

  return locations or {}
end

local function get_locations_signature(locations)
  local parts = {}

  for _, loc in ipairs(locations) do
    table.insert(parts, loc.kind or SIG_UNKNOWN)
    table.insert(parts, loc.name or SIG_UNKNOWN)
  end

  return table.concat(parts, SIG_SEPARATOR)
end

local function get_icon_highlight(location)
  local highlight = nil

  xpcall(
    function()
      highlight = utils.get_highlight(
        require("aerial.highlight").get_highlight(location, true, false)
      )
    end,
    function(err)
      vim.notify(
        "Failed to get Aerial icon highlight: " .. tostring(err),
        vim.log.levels.WARN,
        { once = true }
      )
    end
  )

  return highlight or {}
end

local function new_truncation(omitted_count)
  local index = math.max(1, math.min(omitted_count, #TRUNCATION_MARKS))

  return {
    TrailDelimiter,
    {
      provider = TRUNCATION_MARKS[index],
      hl       = INACTIVE_HL,
    },
  }
end

local function new_breadcrumb(location)
  local symbol_name    = location.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "")
  local symbol_icon    = location.icon
  local symbol_icon_hl = get_icon_highlight(location)

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

-- Inspired by [AstroNvim](https://github.com/AstroNvim/astroui)
return {
  flexible  = 1,

  condition = function(self)
    return self.is_active and package.loaded["aerial"]
  end,

  update = "CursorMoved",

  init = function(self)
    local locations = get_locations()
    local signature = get_locations_signature(locations)

    if self.last_signature == signature then
      return
    end

    self.last_signature    = signature

    local locations_count  = #locations
    local childs_count     = 0

    local function add_child(child)
      childs_count       = childs_count + 1
      self[childs_count] = self:new(child, childs_count)
    end

    if locations_count > 0 then
      local omitted_count = math.max(0, locations_count - MAX_BREADCRUMBS)
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
        local offset  = locations_count - (MAX_BREADCRUMBS - 2) + 1

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
    if self_count > childs_count then
      for i = childs_count + 1, self_count do
        self[i] = nil
      end
    end
  end,
}
