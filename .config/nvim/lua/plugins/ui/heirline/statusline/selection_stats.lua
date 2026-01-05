local Delimiter = require("plugins.ui.heirline.shared").Delimiter

return {
  condition = function(self)
    return self.vimode_spec.is_visual or self.vimode_spec.is_selection
  end,

  update = {
    "ModeChanged",
    "CursorMoved",
    "CursorMovedI",
  },

  hl = { fg = "selection_stats_fg", bold = true },

  init = function(self)
    local line_start = vim.fn.line("v")
    local line_end   = vim.fn.line(".")

    if line_start > line_end then
      line_start, line_end = line_end, line_start
    end

    self.sel_lines = line_end - line_start + 1

    local col_start = vim.fn.col("v")
    local col_end   = vim.fn.col(".")

    if col_start > col_end then
      col_start, col_end = col_end, col_start
    end

    self.sel_cols = col_end - col_start + 1
  end,

  Delimiter,

  {
    condition = function(self)
      return self.vimode_spec.is_visual_char or self.vimode_spec.is_selection_char
    end,

    provider = function(self)
      if self.sel_lines == 1 then
        return string.format(" %dC ", self.sel_cols)
      else
        return string.format(" %dL ", self.sel_lines)
      end
    end,
  },

  {
    condition = function(self)
      return self.vimode_spec.is_visual_line or self.vimode_spec.is_selection_line
    end,

    provider = function(self)
      return string.format(" %dL ", self.sel_lines)
    end,
  },

  {
    condition = function(self)
      return self.vimode_spec.is_visual_block or self.vimode_spec.is_selection_block
    end,

    provider = function(self)
      return string.format(" %dx%d ", self.sel_lines, self.sel_cols)
    end,
  },
}
