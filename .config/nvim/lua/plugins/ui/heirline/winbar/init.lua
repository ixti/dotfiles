local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local FileInfo = require("plugins.ui.heirline.winbar.file_info")
local GitHunks = require("plugins.ui.heirline.winbar.git_hunks")
local LspInfo  = require("plugins.ui.heirline.winbar.lsp_info")

local FileWinbar = {
  init = function(self)
    self.is_active = conditions.is_active()
    self.normal_hl = utils.get_highlight("Normal")
    self.dimmed_hl = utils.get_highlight("Comment")
    self.winbar_hl = utils.get_highlight(self.is_active and "WinBar" or "WinBarNC")
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
      {
        flexible = 1,
        { LspInfo },
        { provider = "" },
      },

      { provider = "%=" },
      FileInfo,
      { provider = "%=" },

      {
        flexible = 1,
        { GitHunks },
        { provider = "" },
      },
    }
  ),
}

return {
  fallthrough = false,

  FileWinbar,
}
