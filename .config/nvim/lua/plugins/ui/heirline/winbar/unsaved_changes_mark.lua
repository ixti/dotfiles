local Space     = require("plugins.ui.heirline.shared").Space
local if_active = require("plugins.ui.heirline.shared").if_active

return {
  condition = function() return vim.bo.modified end,

  Space,
  {
    provider = "*",
    hl       = if_active({ fg = "unsaved_changes_mark_fg" }, { fg = "winbar_inactive_fg" }),
  },
}
