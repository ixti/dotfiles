local Vimode      = require("plugins.ui.heirline.statusline.vimode")
local GitBranch   = require("plugins.ui.heirline.statusline.git_branch")
local Tabs        = require("plugins.ui.heirline.statusline.tabs")
local Ruler       = require("plugins.ui.heirline.statusline.ruler")
local Filler      = require("plugins.ui.heirline.shared").Filler
local VimodeSpec  = require("plugins.ui.heirline.shared.vimode_spec")

return {
  init = function(self)
    self.vimode_spec = VimodeSpec.get(vim.fn.mode(1))
  end,

  flexible = true,

  { Vimode.Long, GitBranch, Filler, Tabs, Ruler },
  { Vimode.Long, Filler, Tabs, Ruler },
  { Vimode.Short, Filler, Tabs },
  { Vimode.Shortest, Filler, Tabs },
}
