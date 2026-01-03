local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")

local FileWinbar = {
  init = function(self)
    self.is_active   = conditions.is_active()
    self.inactive_hl = { fg = utils.get_highlight("Comment").fg, force = true }
  end,

  hl = function(self)
    return (not self.is_active) and self.inactive_hl
  end,

  { provider = " " },
  FileInfo,
  { provider = "%=" },
  {
    flexible = 1,
    { UnsavedChangesMark, GitHunks, ReadOnlyFileMark },
    { UnsavedChangesMark, ReadOnlyFileMark },
  },
  { provider = " " },
}

return {
  fallthrough = false,

  FileWinbar,
}
