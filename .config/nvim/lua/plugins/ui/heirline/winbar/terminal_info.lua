local MiniIcons = require("mini.icons")

local if_active = require("plugins.ui.heirline.shared").if_active

local icon, icon_hl, has_icon = MiniIcons.get("default", "os")

local TerminalIcon = {
  provider = function()
    return has_icon and (icon .. " ") or "TERMINAL: "
  end,

  hl = icon_hl,
}

local TerminalName = {
  provider = function()
    local name = vim.api.nvim_buf_get_name(0):gsub(".*:", "")

    return name ~= "" and name or "unknown"
  end,
}

return {
  hl = if_active({ bold = true }, { fg = "winbar_inactive_fg", force = true }),

  TerminalIcon,
  TerminalName,
}
