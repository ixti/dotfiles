local Space = require("plugins.ui.heirline.shared").Space

return {
  condition = function() return vim.bo.modified end,

  Space,
  { provider = "*", hl = "Changed" },
}
