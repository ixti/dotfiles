local Vimode         = require("plugins.ui.heirline.statusline.vimode")
local GitBranch      = require("plugins.ui.heirline.statusline.git_branch")
local Tabs           = require("plugins.ui.heirline.statusline.tabs")
local SearchStats    = require("plugins.ui.heirline.statusline.search_stats")
local SelectionStats = require("plugins.ui.heirline.statusline.selection_stats")
local MacroRecording = require("plugins.ui.heirline.statusline.macro_recording")
local Ruler          = require("plugins.ui.heirline.statusline.ruler")
local Filler         = require("plugins.ui.heirline.shared").Filler
local VimodeSpec     = require("plugins.ui.heirline.shared.vimode_spec")

return {
  init = function(self)
    self.vimode_spec = VimodeSpec.get(vim.fn.mode(1))
  end,

  flexible = 42,

  { Vimode.Short, MacroRecording, GitBranch, Filler, SelectionStats, SearchStats, Tabs, Ruler },
  { Vimode.Short, MacroRecording, Filler, SelectionStats, SearchStats, Tabs, Ruler },
  { Vimode.Short, Filler, SelectionStats, SearchStats, Tabs, Ruler },
  { Vimode.Short, Filler, SearchStats, Tabs, Ruler },
  { Vimode.Short, Filler, Tabs, Ruler },
  { Vimode.Short, Filler, Tabs },
  { Vimode.Shortest, Filler, Tabs },
}
