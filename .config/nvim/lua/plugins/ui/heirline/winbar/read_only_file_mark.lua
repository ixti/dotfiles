local Delimiter = require("plugins.ui.heirline.winbar.delimiter")

return {
  condition = function() return not vim.bo.modifiable or vim.bo.readonly end,

  Delimiter,

  { provider = "RO", hl = "Error" },
}
