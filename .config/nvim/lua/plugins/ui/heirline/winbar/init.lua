local conditions         = require("heirline.conditions")

local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local Diagnostics        = require("plugins.ui.heirline.winbar.diagnostics")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")
local TerminalInfo       = require("plugins.ui.heirline.winbar.terminal_info")
local Space              = require("plugins.ui.heirline.shared").Space
local Filler             = require("plugins.ui.heirline.shared").Filler

local function WinbarInit(self)
  self.is_active = conditions.is_active()
end

return {
  fallthrough = false,

  -- Terminal
  {
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    init = WinbarInit,

    Space,
    TerminalInfo,
    Filler,
    Space,
  },

  -- Regular files
  {
    init = WinbarInit,

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
