local Delimiter = require("plugins.ui.heirline.shared").Delimiter

local searchcount = vim.fn.searchcount

return {
  condition = function()
    return vim.v.hlsearch == 1 and searchcount({ recompute = 0 }).total > 0
  end,

  update = {
    "CmdlineLeave",
    "CursorMoved",
    "CursorMovedI",
  },

  init = function(self)
    local search_count = searchcount({ recompute = 1, maxcount = 1000 })

    self.sc_current = search_count.current
    self.sc_total   = search_count.total
  end,

  Delimiter,

  {
    hl = { fg = "search_stats_fg" },

    provider = function(self)
      if self.sc_total == 0 then
        return ""
      elseif self.sc_total > 999 then
        return string.format(" %d/999+ ", self.sc_current)
      end

      return string.format(" %d/%d ", self.sc_current, self.sc_total)
    end,
  },
}
