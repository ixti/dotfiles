local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local Space     = require("plugins.ui.heirline.shared").Space

return {
  condition = function() return vim.bo.modified end,

  Space,
  Delimiter,
  Space,

  { provider = "*", hl = "Changed" },
}
