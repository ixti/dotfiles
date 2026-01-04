local utils = require("heirline.utils")

local Tab = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
  end,

  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end,
}

return {
  utils.make_tablist(Tab),
}
