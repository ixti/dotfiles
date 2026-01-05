local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local Space     = require("plugins.ui.heirline.shared").Space
local if_active = require("plugins.ui.heirline.shared").if_active
local buf_diag  = require("plugins.ui.heirline.shared.buffer_diagnostics")

local function diag_prefix(severity, fallback)
  local signs = vim.diagnostic.config().signs

  if type(signs) ~= "table" then
    return fallback
  end

  return signs.text and signs.text[severity] or fallback
end

local errors_prefix   = diag_prefix(vim.diagnostic.severity.ERROR, "E")
local warnings_prefix = diag_prefix(vim.diagnostic.severity.WARN,  "W")
local hints_prefix    = diag_prefix(vim.diagnostic.severity.HINT,  "H")
local infos_prefix    = diag_prefix(vim.diagnostic.severity.INFO,  "I")

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
      hl        = if_active({ fg = "diag_errors_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_errors end,
      provider  = function(self) return (" " .. errors_prefix .. " ".. self.errors) end,
    },

    {
      hl        = if_active({ fg = "diag_warnings_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_warnings end,
      provider  = function(self) return (" " .. warnings_prefix .. " " .. self.warnings) end,
    },

    {
      hl        = if_active({ fg = "diag_hints_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_hints end,
      provider  = function(self) return (" " .. hints_prefix .. " " .. self.hints) end,
    },

    {
      hl        = if_active({ fg = "diag_infos_fg" }, { fg = "inactive_fg" }),
      condition = function(self) return self.has_infos end,
      provider  = function(self) return (" " .. infos_prefix .. " " .. self.infos) end,
    },
  },
}
