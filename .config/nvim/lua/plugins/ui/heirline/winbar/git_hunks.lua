local Delimiter  = require("plugins.ui.heirline.shared").Delimiter
local Space      = require("plugins.ui.heirline.shared").Space
local if_active  = require("plugins.ui.heirline.shared").if_active

return {
  condition = function()
    return type(vim.b.gitsigns_status_dict) == "table"
  end,

  init = function(self)
    -- Event though condition is checking for correct type, if by some reason
    -- between condition call and init buffer-locals gets changed we won't fail
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

    Space,
    Delimiter,

    {
      hl        = if_active({ fg = "git_hunks_added_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_lines_added end,
      provider  = function(self) return (" +" .. self.lines_added) end,
    },

    {
      hl        = if_active({ fg = "git_hunks_removed_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_lines_removed end,
      provider  = function(self) return (" -" .. self.lines_removed) end,
    },

    {
      hl        = if_active({ fg = "git_hunks_changed_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_lines_changed end,
      provider  = function(self) return (" ~" .. self.lines_changed) end,
    },
  },
}
