local conditions         = require("heirline.conditions")
local utils              = require("heirline.utils")

local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local Diagnostics        = require("plugins.ui.heirline.winbar.diagnostics")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")
local TerminalInfo       = require("plugins.ui.heirline.winbar.terminal_info")
local Space              = require("plugins.ui.heirline.shared").Space
local Filler             = require("plugins.ui.heirline.shared").Filler

local WinbarInit = function(self)
  self.is_active = conditions.is_active()
end

local InactiveHL = { fg = utils.get_highlight("Comment").fg, force = true }
local WinbarHL   = function(self)
  return (not self.is_active) and InactiveHL
end

return {
  fallthrough = false,

  -- Terminal
  {
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    init = WinbarInit,
    hl   = WinbarHL,

    Space,
    TerminalInfo,
    Filler,
    Space,
  },

  -- Regular files
  {
    init = WinbarInit,
    hl   = WinbarHL,

    Space,
    FileInfo,
    Filler,
    {
      flexible = 1,
      { UnsavedChangesMark, Diagnostics, GitHunks, ReadOnlyFileMark },
      { UnsavedChangesMark, Diagnostics, ReadOnlyFileMark },
      { UnsavedChangesMark, ReadOnlyFileMark },
    },
    Space,
  },
}
