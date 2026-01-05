local Delimiter  = require("plugins.ui.heirline.shared").Delimiter
local Space      = require("plugins.ui.heirline.shared").Space
local if_active  = require("plugins.ui.heirline.shared").if_active

return {
  condition = function(self)
    return (not self.is_special) and vim.bo.fileformat ~= "unix"
  end,

  Space,
  Delimiter,

  {
    hl       = if_active({ fg = "diag_warnings_fg" }, { fg = "inactive_fg" }),
    provider = function()
      local format = vim.bo.fileformat

      return " " .. (format == "dos" and "CRLF" or format:upper())
    end,
  },
}
