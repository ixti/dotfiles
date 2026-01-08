local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local Space     = require("plugins.ui.heirline.shared").Space
local if_active = require("plugins.ui.heirline.shared").if_active

return {
  condition = function() return not vim.bo.modifiable or vim.bo.readonly end,

  Space,
  Delimiter,
  Space,

  {
    provider = "RO",
    hl        = if_active({ fg = "read_only_file_mark_fg" }, { fg = "inactive_fg" }),
  },
}
