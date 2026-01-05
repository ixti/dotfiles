local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local if_active = require("plugins.ui.heirline.shared").if_active

local Tab = {
  provider = function(self)
    if self.is_active then
      return "%" .. self.tabnr .. "T(" .. self.tabpage .. ")%T"
    else
      return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
    end
  end,

  hl = if_active({ bold = true }, { bold = false }),
}

-- Heavily based on heirline's make_tablist,
-- main difference is adding tab separator
return {
  init = function(self)
    local tabpages    = vim.api.nvim_list_tabpages()
    local child_index = 1

    for i, tabpage in ipairs(tabpages) do
      local tabnr = vim.api.nvim_tabpage_get_number(tabpage)
      local child = self[child_index]

      if not (child and child.tabpage == tabpage) then
        child             = self:new(Tab, i)
        child.tabnr       = tabnr
        child.tabpage     = tabpage

        self[child_index] = child
      end

      if tabpage == vim.api.nvim_get_current_tabpage() then
        child.is_active   = true
        self.active_child = child_index
      else
        child.is_active = false
      end

      child_index = child_index + 1

      -- This is basically the main difference, LOL
      if i < #tabpages then
        local delimiter = self[child_index]

        if not delimiter or not delimiter.is_delimiter then
          self[child_index] = self:new(Delimiter)
          self[child_index].is_delimiter = true
        end

        child_index = child_index + 1
      end
    end

    -- Clean up any remaining children
    if #self > child_index - 1 then
      for i = child_index, #self do
        self[i] = nil
      end
    end
  end,
}
