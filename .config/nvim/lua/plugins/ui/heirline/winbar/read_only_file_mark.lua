local utils = require("heirline.utils")

local Delimiter = require("plugins.ui.heirline.winbar.delimiter")

return {
  condition = function() return not vim.bo.modifiable or vim.bo.readonly end,

  Delimiter,

  {
    provider  = "󰌾",

    hl = function(self)
      return self.is_active and utils.get_highlight("Error") or self.inactive_hl
    end,
  },
}
