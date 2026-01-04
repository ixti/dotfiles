local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local Space     = require("plugins.ui.heirline.shared").Space
local if_active = require("plugins.ui.heirline.shared").if_active
local buf_diag  = require("plugins.ui.heirline.shared.buffer_diagnostics")

return {
  init = function(self)
    local diag = buf_diag.get()

    self.errors       = diag.errors
    self.warnings     = diag.warnings
    self.hints        = diag.hints
    self.infos        = diag.infos

    self.has_errors   = diag.errors   > 0
    self.has_warnings = diag.warnings > 0
    self.has_hints    = diag.hints    > 0
    self.has_infos    = diag.infos    > 0
  end,

  {
    condition = function(self)
      return self.has_errors or self.has_warnings or self.has_hints or self.has_infos
    end,

    Space,
    Delimiter,

    {
      hl        = if_active({ fg = "diag_errors_fg" }, { fg = "winbar_inactive_fg" }),
      condition = function(self) return self.has_errors end,
      provider  = function(self) return (" E:" .. self.errors) end,
    },

    {
      hl        = if_active({ fg = "diag_warnings_fg" }, { fg = "winbar_inactive_fg" }),
      condition = function(self) return self.has_warnings end,
      provider  = function(self) return (" W:" .. self.warnings) end,
    },

    {
      hl        = if_active({ fg = "diag_hints_fg" }, { fg = "winbar_inactive_fg" }),
      condition = function(self) return self.has_hints end,
      provider  = function(self) return (" H:" .. self.hints) end,
    },

    {
      hl        = if_active({ fg = "diag_infos_fg" }, { fg = "winbar_inactive_fg" }),
      condition = function(self) return self.has_infos end,
      provider  = function(self) return (" I:" .. self.infos) end,
    },
  },
}
