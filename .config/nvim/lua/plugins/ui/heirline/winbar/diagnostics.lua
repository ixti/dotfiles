local conditions = require("heirline.conditions")

local Delimiter  = require("plugins.ui.heirline.shared").Delimiter
local Space      = require("plugins.ui.heirline.shared").Space

return {
  condition = conditions.has_diagnostics,

  update = { "DiagnosticChanged", "BufEnter" },

  init = function(self)
    self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.infos    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

    self.has_errors   = self.errors > 0
    self.has_warnings = self.warnings > 0
    self.has_hints    = self.hints > 0
    self.has_infos    = self.infos > 0
  end,

  {
    condition = function(self)
      return self.has_errors or self.has_warnings or self.has_hints or self.has_infos
    end,

    Space,
    Delimiter,

    {
      hl        = "DiagnosticError",
      condition = function(self) return self.has_errors end,
      provider  = function(self) return (" E:" .. self.errors) end,
    },

    {
      hl        = "DiagnosticWarn",
      condition = function(self) return self.has_warnings end,
      provider  = function(self) return (" W:" .. self.warnings) end,
    },

    {
      hl        = "DiagnosticHint",
      condition = function(self) return self.has_hints end,
      provider  = function(self) return (" H:" .. self.hints) end,
    },

    {
      hl        = "DiagnosticInfo",
      condition = function(self) return self.has_infos end,
      provider  = function(self) return (" I:" .. self.infos) end,
    },
  },
}
