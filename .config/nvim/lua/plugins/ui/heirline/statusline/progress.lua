local Space     = require("plugins.ui.heirline.shared").Space
local Delimiter = require("plugins.ui.heirline.shared").Delimiter

  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window

local Progress = { provider = "%P" }
local Ruler    = {
  update = {
    "ModeChanged",
    pattern  = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
  },

  provider = " %l/%L:%c ",
  hl       = function(self) return self.vimode_spec:hl({ bold = true }) end,
}

return {
  flexible = 1,

  { Delimiter, Space, Progress, Space, Ruler },
  { Ruler },
  { provider = "" },
}
