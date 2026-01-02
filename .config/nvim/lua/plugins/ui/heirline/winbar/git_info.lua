local utils = require("heirline.utils")

return {
  condition = utils.is_git_repo,

  init = function(self)
    local status_dict = vim.b.gitsigns_status_dict or {}

    self.lines_added       = status_dict.added or 0
    self.has_lines_added   = self.lines_added > 0
    self.lines_removed     = status_dict.removed or 0
    self.has_lines_removed = self.lines_removed > 0
    self.lines_changed     = status_dict.changed or 0
    self.has_lines_changed = self.lines_changed > 0
  end,

  {
    condition = function(self)
      return self.has_lines_added or self.has_lines_removed or self.has_lines_changed
    end,

    provider = " "
  },

  {
    provider = function(self)
      return self.has_lines_added and ("+" .. self.lines_added)
    end,

    hl = "GitSignsAdd",
  },

  {
    provider = function(self)
      local prefix = self.has_lines_added and " -" or "-"

      return self.has_lines_removed and (prefix .. self.lines_removed)
    end,

    hl = "GitSignsDelete",
  },

  {
    provider = function(self)
      local prefix = (self.has_lines_added or self.has_lines_removed) and " ~" or "~"

      return self.has_lines_changed and (prefix .. self.lines_changed)
    end,

    hl = "GitSignsChange",
  },
}
