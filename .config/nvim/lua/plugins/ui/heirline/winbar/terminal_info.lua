local MiniIcons = require("mini.icons")

local if_active = require("plugins.ui.heirline.shared").if_active

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
}

return {
  hl = if_active({ bold = true }, { fg = "winbar_inactive_fg", force = true }),

  TerminalIcon,
  TerminalName,
}
