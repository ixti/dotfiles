local Vimode      = require("plugins.ui.heirline.statusline.vimode")
local GitBranch   = require("plugins.ui.heirline.statusline.git_branch")
local Tabs        = require("plugins.ui.heirline.statusline.tabs")
local Ruler       = require("plugins.ui.heirline.statusline.ruler")
local Filler      = require("plugins.ui.heirline.shared").Filler
local Delimiter   = require("plugins.ui.heirline.shared").Delimiter
local VimodeSpec  = require("plugins.ui.heirline.shared.vimode_spec")

return {
  init = function(self)
    self.vimode_spec = VimodeSpec.get(vim.fn.mode(1))
  end,

  flexible = true,

  { Vimode.Long, GitBranch, Filler, Delimiter, Tabs, Delimiter, Ruler },
  { Vimode.Long, Filler, Delimiter, Tabs, Delimiter, Ruler },
  { Vimode.Short, Filler, Delimiter, Tabs },
  { Vimode.Shortest, Filler, Delimiter, Tabs },
}
