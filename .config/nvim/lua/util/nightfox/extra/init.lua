local M = {}

local TEMPLATES_PATH = vim.fn.stdpath("config") .. "/lua/util/nightfox/extra"
local kitty          = vim.fn.readfile(TEMPLATES_PATH .. "/kitty.conf")
local vivid          = vim.fn.readfile(TEMPLATES_PATH .. "/vivid.yml")
local bat            = vim.fn.readfile(TEMPLATES_PATH .. "/bat.tmTheme")

local function resolve_color(v, path)
  for segment in path:gmatch("[^.]+") do
    if type(v) ~= "table" then
      error("Unresolvable template variable: " .. path, 2)
    end

    v = v[segment]
  end

  if type(v) ~= "string" then
    error("Invalid value for: " .. path, 2)
  end

  return v
end

local function render(template, palette, normalize)
  local lines = {}

  if not normalize then
    normalize = function(v) return v end
  end

  for _, s in ipairs(template) do
    local _s = s:gsub("($%b{})", function(w)
      return normalize(resolve_color(palette, w:sub(3, -2)))
    end)

    table.insert(lines, _s)
  end

  return lines
end

local function generate(template, opts)
  local dirname = vim.fn.expand(opts.dirname)

  for name, scheme in pairs(opts.schemes) do
    local fname = dirname .. "/" .. name .. "." .. opts.extname
    local object = render(template, scheme, opts.normalize)

    vim.fn.writefile(object, fname, "s")
  end
end

function M.generate()
  -- Ensure colors are up to date (if compile = true)
  require("nightfox").compile()

  local specs = require("nightfox.spec").load()

  -- Looks weird, right? That's because Nightfox allows to override palette of
  -- any of the built-in colorscheme. Thus, as long as nightfox palette was
  -- overriden with Flexoki colors - we're good ;))
  local schemes = {
    ["flexoki-dark"]  = specs.nightfox.palette,
    ["flexoki-light"] = specs.dayfox.palette,
  }

  generate(bat, {
    dirname = "~/.config/bat/themes",
    extname = "tmTheme",
    schemes = schemes,
  })

  generate(kitty, {
    dirname = "~/.config/kitty/themes",
    extname = "conf",
    schemes = schemes,
  })

  generate(vivid, {
    dirname   = "~/.config/vivid/themes",
    extname   = "yml",
    schemes   = schemes,
    normalize = function(v) return v:sub(2, -1) end
  })
end

return M
