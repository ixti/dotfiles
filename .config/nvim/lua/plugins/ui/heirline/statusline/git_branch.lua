local MiniIcons  = require("mini.icons")
local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local Space      = require("plugins.ui.heirline.shared").Space

local git_icon, git_hl = MiniIcons.get("filetype", "git")

return {
  condition = conditions.is_git_repo,

  init = function(self)
    self.git_head = vim.b.gitsigns_head
  end,

  hl = function()
    return git_hl or utils.get_highlight("Special")
  end,

  Space,

  {
    provider = function()
      return git_icon and (git_icon .. " ")
    end,
  },

  {
    provider = function(self)
      return self.git_head
    end,
    hl = { bold = true }
  },
}
