local utils = require("heirline.utils")

local M = {}

M.Filler     = { provider = "%=" }
M.Space      = { provider = " " }
M.Delimiter  = { provider = "│", hl = { fg = utils.get_highlight("Conceal").fg, force = true } }

return M
