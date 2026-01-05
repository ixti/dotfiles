local Delimiter  = require("plugins.ui.heirline.shared").Delimiter
local Space      = require("plugins.ui.heirline.shared").Space
local if_active  = require("plugins.ui.heirline.shared").if_active

return {
  condition = function(self)
    local fileencoding = vim.bo.fileencoding

    return (not self.is_special) and fileencoding ~= "utf-8" and fileencoding ~= ""
  end,

  Space,
  Delimiter,

  {
    hl       = if_active({ fg = "diag_warnings_fg" }, { fg = "inactive_fg" }),
    provider = function() return (" " .. vim.bo.fileencoding:upper()) end,
  },
}
