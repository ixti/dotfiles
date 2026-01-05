local Delimiter = require("plugins.ui.heirline.shared").Delimiter

return {
  condition = function()
    return vim.fn.reg_recording() ~= ""
  end,

  update = {
    "RecordingEnter",
    "RecordingLeave",
  },

  hl = { fg = "macro_recording_fg", bold = true },

  provider = function()
    return " ● " .. vim.fn.reg_recording() .. " "
  end,

  Delimiter,
}
