local MiniIcons = require("mini.icons")

local TerminalIcon = {
  init = function(self)
    self.icon, self.icon_color = MiniIcons.get("default", "os")
  end,

  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,

  hl = function(self)
    return self.icon_color
  end,
}

local TerminalName = {
  provider = function()
    return vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  end,

  hl = function(self)
    return self.is_active and { bold = true }
  end,
}

return {
  TerminalIcon,
  TerminalName,
}
