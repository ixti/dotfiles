local MiniIcons  = require("mini.icons")
local conditions = require("heirline.conditions")

local if_active  = require("plugins.ui.heirline.shared").if_active

local default_icon, default_icon_hl = MiniIcons.get("default", "file")

local FileIcon = {
  init = function(self)
    if self.filename == "" then
      self.icon     = default_icon
      self.icon_hl  = default_icon_hl
    else
      self.icon, self.icon_hl = MiniIcons.get("file", self.filename)
    end
  end,

  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,

  hl = function(self)
    return self.icon_hl
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":.")

    if filename == "" then return "[No Name]" end

    -- now, if the filename would occupy more than half of the available
    -- space, we trim the file path to its initials
    if not conditions.width_percent_below(#filename, 0.5) then
      filename = vim.fn.pathshorten(filename)
    end

    return filename
  end,
}

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,

  hl = if_active({ bold = true }, { fg = "winbar_inactive_fg", force = true }),

  FileIcon,
  FileName,
}
