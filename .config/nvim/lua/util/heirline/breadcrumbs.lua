local utils = require("heirline.utils")

local M = {}

local SIG_SEPARATOR         = "\n"
local SIG_UNKNOWN           = "\0"

local TRUNCATION_MARKS      = { "…", "…2…", "…3…", "…4…", "…5…", "…6…", "…7…", "…8…", "…9…", "…9+…" }
local TRUNCATION_MARKS_SIZE = #TRUNCATION_MARKS

local icon_hl_cache         = {}

local function icon_hl_cache_key(location)
  local scope = location.scope or SIG_UNKNOWN
  local kind  = location.kind or SIG_UNKNOWN

  return scope .. SIG_SEPARATOR .. kind
end

function M.get_icon_highlight(location)
  local cache_key = icon_hl_cache_key(location)
  local highlight = nil

  if icon_hl_cache[cache_key] then
    highlight = icon_hl_cache[cache_key]
  else
    xpcall(
      function()
        highlight = require("aerial.highlight").get_highlight(location, true, false)
      end,
      function(err)
        vim.notify(
          "Failed to get Aerial icon highlight: " .. tostring(err),
          vim.log.levels.WARN,
          { once = true }
        )
      end
    )

    highlight                = highlight or {}
    icon_hl_cache[cache_key] = highlight
  end

  return utils.get_highlight(highlight)
end

function M.get_locations_signature(locations)
  local parts = {}

  for _, loc in ipairs(locations) do
    table.insert(parts, (loc and loc.kind) or SIG_UNKNOWN)
    table.insert(parts, (loc and loc.name) or SIG_UNKNOWN)
  end

  return table.concat(parts, SIG_SEPARATOR)
end

function M.get_locations()
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

function M.get_truncation_mark(omitted_count)
  return TRUNCATION_MARKS[math.max(1, math.min(omitted_count, TRUNCATION_MARKS_SIZE))]
end

return M
