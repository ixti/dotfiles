local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")

local FileWinbar = {
  init = function(self)
    self.is_active   = conditions.is_active()
    self.normal_hl   = utils.get_highlight("Normal")
    self.winbar_hl   = utils.get_highlight(self.is_active and "WinBar" or "WinBarNC")
    self.inactive_hl = { fg = utils.get_highlight("Comment").fg }
  end,

  hl = function(self)
    return { bg = self.normal_hl.bg, fg = self.winbar_hl.fg }
  end,

  utils.surround(
    { "", "" },

    function(self)
      return self.winbar_hl.bg
    end,

    {
      FileInfo,
      { provider = "%=" },
      {
        flexible = 1,
        { UnsavedChangesMark, GitHunks, ReadOnlyFileMark },
        { UnsavedChangesMark, ReadOnlyFileMark },
      },
    }
  ),
}

return {
  fallthrough = false,

  FileWinbar,
}
