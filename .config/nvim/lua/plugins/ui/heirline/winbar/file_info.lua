local MiniIcons  = require("mini.icons")
local conditions = require("heirline.conditions")

local FileIcon = {
  init = function(self)
    self.icon, self.icon_color = MiniIcons.get("file", self.filename)
  end,

  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,

  hl = function(self)
    return self.icon_color
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

  hl = function(self)
    return self.is_active and { bold = true }
  end,
}

return {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,

  FileIcon,
  FileName,
}
