local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local FileInfo = require("plugins.ui.heirline.winbar.file_info")
local GitHunks = require("plugins.ui.heirline.winbar.git_hunks")

local FileWinbar = {
  FileInfo,
  { provider = "%=" },
  {
    flexible = 1,

    { GitHunks },
    { provider = "" },
  },
}

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

    FileWinbar,
  },

  -- Active Regular File
  FileWinbar,
}
