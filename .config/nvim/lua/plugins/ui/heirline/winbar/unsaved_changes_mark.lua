local Delimiter = require("plugins.ui.heirline.winbar.delimiter")

return {
  condition = function() return vim.bo.modified end,

  Delimiter,

  { provider = "*", hl = "Changed" },
}
