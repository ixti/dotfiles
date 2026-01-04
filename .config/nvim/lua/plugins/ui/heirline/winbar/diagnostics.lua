local conditions = require("heirline.conditions")

local Delimiter  = require("plugins.ui.heirline.shared").Delimiter
local Space      = require("plugins.ui.heirline.shared").Space
local if_active  = require("plugins.ui.heirline.shared").if_active

local DIAG_SEV_ERROR = vim.diagnostic.severity.ERROR
local DIAG_SEV_WARN  = vim.diagnostic.severity.WARN
local DIAG_SEV_HINT  = vim.diagnostic.severity.HINT
local DIAG_SEV_INFO  = vim.diagnostic.severity.INFO

return {
  condition = conditions.has_diagnostics,

  update = {
    "DiagnosticChanged",
    "BufEnter",
    "WinEnter",
    "WinLeave"
  },

  init = function(self)
    local errors    = 0
    local warnings  = 0
    local hints     = 0
    local infos     = 0

    for _, diag in ipairs(vim.diagnostic.get(0)) do
      if     diag.severity == DIAG_SEV_ERROR then errors   = errors + 1
      elseif diag.severity == DIAG_SEV_WARN  then warnings = warnings + 1
      elseif diag.severity == DIAG_SEV_HINT  then hints    = hints + 1
      elseif diag.severity == DIAG_SEV_INFO  then infos    = infos + 1
      end
    end

    self.errors       = errors
    self.warnings     = warnings
    self.hints        = hints
    self.infos        = infos

    self.has_errors   = errors > 0
    self.has_warnings = warnings > 0
    self.has_hints    = hints > 0
    self.has_infos    = infos > 0
  end,

  {
    condition = function(self)
      return self.has_errors or self.has_warnings or self.has_hints or self.has_infos
    end,

    Space,
    Delimiter,
  },

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
}
