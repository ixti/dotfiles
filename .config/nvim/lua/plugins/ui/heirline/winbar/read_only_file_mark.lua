local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local Space     = require("plugins.ui.heirline.shared").Space

return {
  condition = function() return not vim.bo.modifiable or vim.bo.readonly end,

  Space,
  Delimiter,
  Space,

  { provider = "RO", hl = "Error" },
}
