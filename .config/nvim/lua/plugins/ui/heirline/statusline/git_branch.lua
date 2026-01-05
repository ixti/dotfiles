local MiniIcons  = require("mini.icons")
local conditions = require("heirline.conditions")

local Space      = require("plugins.ui.heirline.shared").Space

local git_icon   = MiniIcons.get("filetype", "git")

return {
  condition = conditions.is_git_repo,

  init = function(self)
    self.git_head = vim.b.gitsigns_head
  end,

  hl = { fg = "git_branch_fg", bold = true },

  Space,

  {
    condition = function() return (git_icon and true or false) end,
    provider  = (git_icon .. " "),
  },

  {
    provider = function(self)
      return self.git_head
    end,
  },
}
