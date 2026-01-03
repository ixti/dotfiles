local utils = require("heirline.utils")

local Delimiter = require("plugins.ui.heirline.winbar.delimiter")

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

    self.lines_added_hl    = utils.get_highlight("GitSignsAdd")
    self.lines_removed_hl  = utils.get_highlight("GitSignsDelete")
    self.lines_changed_hl  = utils.get_highlight("GitSignsChange")
  end,

  {
    condition = function(self)
      return self.has_lines_added or self.has_lines_removed or self.has_lines_changed
    end,

    Delimiter
  },

  {
    provider = function(self)
      return self.has_lines_added and ("+" .. self.lines_added)
    end,

    hl = function(self)
      return self.lines_added_hl
    end,
  },

  {
    provider = function(self)
      local prefix = self.has_lines_added and " -" or "-"

      return self.has_lines_removed and (prefix .. self.lines_removed)
    end,

    hl = function(self)
      return self.lines_removed_hl
    end,
  },

  {
    provider = function(self)
      local prefix = (self.has_lines_added or self.has_lines_removed) and " ~" or "~"

      return self.has_lines_changed and (prefix .. self.lines_changed)
    end,

    hl = function(self)
      return self.lines_changed_hl
    end,
  },
}
