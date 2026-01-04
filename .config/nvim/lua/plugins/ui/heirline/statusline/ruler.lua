return {
  update = {
    "ModeChanged",
    pattern  = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
  },

  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = " %l/%L:%c ",
  hl       = function(self) return self.vimode_spec:hl({ bold = true }) end,
}
