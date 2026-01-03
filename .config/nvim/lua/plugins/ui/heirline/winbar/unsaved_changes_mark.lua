local utils = require("heirline.utils")

local Delimiter = require("plugins.ui.heirline.winbar.delimiter")

return {
  condition = function() return vim.bo.modified end,

  Delimiter,

  {
    provider  = "*",

    hl = function(self)
      return self.is_active and utils.get_highlight("Changed") or self.inactive_hl
    end,
  },
}
