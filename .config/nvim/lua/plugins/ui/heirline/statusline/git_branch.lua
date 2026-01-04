local MiniIcons  = require("mini.icons")
local conditions = require("heirline.conditions")
local utils      = require("heirline.utils")

local git_icon, git_hl = MiniIcons.get("filetype", "git")

return {
  condition = conditions.is_git_repo,

  init = function(self)
    local status_dict = vim.b.gitsigns_status_dict or {}

    self.git_head = status_dict.head
  end,

  hl = function()
    return git_hl or utils.get_highlight("Special")
  end,

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
