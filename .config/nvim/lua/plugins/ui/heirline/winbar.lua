local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local FileInfo = require("plugins.ui.heirline.components.file_info")
local GitStats = require("plugins.ui.heirline.components.git_stats")

return {
  fallthrough = false,

  -- Inactive Regular File
  {
    condition = function()
      return not conditions.is_active()
    end,

    hl = function()
      local fg = utils.get_highlight("Comment").fg

      return { fg = fg, sp = fg, force = true }
    end,

    FileInfo,
  },

  -- Active Regular File
  {
    {
      hl = { bold = true },
      FileInfo,
    },

    { provider = "%=" },

    GitStats,
  },
}
