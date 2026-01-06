local conditions         = require("heirline.conditions")

local Aerial             = require("plugins.ui.heirline.winbar.aerial")
local FileInfo           = require("plugins.ui.heirline.winbar.file_info")
local GitHunks           = require("plugins.ui.heirline.winbar.git_hunks")
local Diagnostics        = require("plugins.ui.heirline.winbar.diagnostics")
local ReadOnlyFileMark   = require("plugins.ui.heirline.winbar.read_only_file_mark")
local UnsavedChangesMark = require("plugins.ui.heirline.winbar.unsaved_changes_mark")
local TerminalInfo       = require("plugins.ui.heirline.winbar.terminal_info")
local WeirdFormat        = require("plugins.ui.heirline.winbar.weird_format")
local WeirdEncoding      = require("plugins.ui.heirline.winbar.weird_encoding")
local Space              = require("plugins.ui.heirline.shared").Space
local Filler             = require("plugins.ui.heirline.shared").Filler

local function WinbarInit(self)
  self.is_active  = conditions.is_active()
  self.is_special = vim.bo.filetype == "" or vim.bo.buftype ~= ""
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

    {
      flexible = 42,
      { Aerial, Filler, UnsavedChangesMark, Diagnostics, GitHunks, WeirdEncoding, WeirdFormat, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, Diagnostics, GitHunks, WeirdEncoding, WeirdFormat, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, Diagnostics, GitHunks, WeirdEncoding, WeirdFormat, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, Diagnostics, GitHunks, WeirdEncoding, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, Diagnostics, GitHunks, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, Diagnostics, ReadOnlyFileMark },
      { Filler, UnsavedChangesMark, ReadOnlyFileMark },
    },
    Space,
  },
}
