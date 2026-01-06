local M = {}

M.Filler     = { provider = "%=" }
M.Space      = { provider = " " }
M.Delimiter  = { provider = "│", hl = { fg = "delimiter_fg" } }

function M.if_active(active, inactive)
  return function(self)
    return self.is_active and active or inactive
  end
end

return M
