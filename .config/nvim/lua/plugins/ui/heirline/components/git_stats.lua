local utils = require("heirline.utils")

return {
  condition = utils.is_git_repo,

  init = function(self)
    local status_dict = vim.b.gitsigns_status_dict or {}

    self.lines_added    = status_dict.added or 0
    self.lines_removed  = status_dict.removed or 0
    self.lines_changed  = status_dict.changed or 0
  end,

  {
    provider = function(self)
      return self.lines_added > 0 and ("+" .. self.lines_added)
    end,

    hl = "GitSignsAdd",
  },
  {
    provider = function(self)
      return self.lines_removed > 0 and ("-" .. self.lines_removed)
    end,

    hl = "GitSignsDelete",
  },
  {
    provider = function(self)
      return self.lines_changed > 0 and ("~" .. self.lines_changed)
    end,

    hl = "GitSignsChange",
  },
}
