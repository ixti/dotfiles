local MiniIcons  = require("mini.icons")
local Space      = require("plugins.ui.heirline.shared").Space

local git_icon   = MiniIcons.get("filetype", "git")
git_icon = git_icon and (git_icon .. " ") or ""

return {
  condition = function()
    return type(vim.b.gitsigns_head) == "string"
  end,

  init = function(self)
    -- Event though condition is checking for correct type, if by some reason
    -- between condition call and init buffer-locals gets changed we won't fail
    self.git_head = vim.b.gitsigns_head or ""
  end,

  {
    condition = function(self)
      return self.git_head ~= ""
    end,

    hl = { fg = "git_branch_fg", bold = true },

    Space,

    {
      provider = function(self)
        return git_icon .. self.git_head
      end,
    },
  },
}
