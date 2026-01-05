local Delimiter = require("plugins.ui.heirline.shared").Delimiter
local if_active = require("plugins.ui.heirline.shared").if_active

local NAMES = {
  { "azathoth",       "aza" }, -- 1: The blind idiot god
  { "nyarlathotep",   "nya" }, -- 2: The crawling chaos
  { "cthulhu",        "cth" }, -- 3: The great dreamer
  { "yog-sothoth",    "yog" }, -- 4: The gate and key
  { "shub-niggurath", "shu" }, -- 5: The black goat
  { "dagon",          "dag" }, -- 6: The deep one
  { "hastur",         "has" }, -- 7: The yellow sign
  { "nodens",         "nod" }, -- 8: The sea lord
  { "arkham",         "ark" }, -- 9: The forbidden city
  { "madness",        "mad" }, -- 10+: Fallback
}

local Tab = {
  flexible = 1,

  hl = if_active({ bold = true }, { fg = "inactive_fg" }),

  init = function(self)
    local names = NAMES[math.min(self.tabnr, #NAMES)]

    self.long_name  = names[1]
    self.short_name = names[2]
  end,

  {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. ":" .. self.long_name .. " %T"
    end,
  },

  {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. ":" .. self.short_name .. " %T"
    end,
  },

  {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
    end,
  },
}

-- Heavily based on heirline's make_tablist,
-- main difference is adding tab separator
return {
  Delimiter,

  {
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
  },
}
