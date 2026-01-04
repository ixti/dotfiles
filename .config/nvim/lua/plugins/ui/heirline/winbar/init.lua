local conditions         = require("heirline.conditions")
local utils              = require("heirline.utils")

local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")
local TerminalInfo       = require("plugins.ui.heirline.winbar.terminal_info")
local Shared             = require("plugins.ui.heirline.shared")

local WinbarInit = function(self)
  self.is_active = conditions.is_active()
end

local WinbarHl   = function(self)
  return (not self.is_active) and Shared.InactiveHL
end

return {
  fallthrough = false,

  -- Terminal
  {
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    init = WinbarInit,
    hl   = WinbarHl,

    Shared.Space,
    TerminalInfo,
    Shared.Filler,
    Shared.Space,
  },

  -- Regular files
  {
    init = WinbarInit,
    hl   = WinbarHl,

    Shared.Space,
    FileInfo,
    Shared.Filler,
    {
      flexible = 1,
      { UnsavedChangesMark, GitHunks, ReadOnlyFileMark },
      { UnsavedChangesMark, ReadOnlyFileMark },
    },
    Shared.Space,
  },
}
