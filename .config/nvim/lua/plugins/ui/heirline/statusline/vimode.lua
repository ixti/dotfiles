local Space = require("plugins.ui.heirline.shared").Space

local M = {}

local update = {
  "ModeChanged",
  pattern  = "*:*",
  callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
}

local hl = function(self)
  return self.vimode_spec:hl({ bold = true })
end

local ShortName = {
  provider = function(self)
    return self.vimode_spec.short_name
  end,
}

local LongName = {
  provider = function(self)
    return self.vimode_spec.long_name
  end,
}

M.Shortest = { update = update, hl = hl, ShortName }
M.Short    = { update = update, hl = hl, Space, ShortName, Space }
M.Long     = { update = update, hl = hl, Space, LongName, Space }

return M
