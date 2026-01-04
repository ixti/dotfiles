local utils = require("heirline.utils")

local M = {}

M.InactiveHL = { fg = utils.get_highlight("Comment").fg, force = true }
M.Filler     = { provider = "%=" }
M.Space      = { provider = " " }
M.Delimiter  = { provider = "│", hl = M.InactiveHL }

return M
