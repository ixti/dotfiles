local utils = require("heirline.utils")

local VimodeSpec = {}
VimodeSpec.__index = VimodeSpec

function VimodeSpec:hl(opts)
  local base = utils.get_highlight(self.color)

  return opts and vim.tbl_extend("force", base, opts) or base
end

local function build(color, short_name, long_name)
  local self      = setmetatable({}, VimodeSpec)

  self.color      = color
  self.short_name = short_name
  self.long_name  = long_name

  return self
end

local SPECS = {
  -- Normal mode
  n         = build("HeirlineModeNormal",    "N",   "NORMAL"),
  no        = build("HeirlineModeNormal",    "N?",  "NORMAL (OPERATOR)"),
  nov       = build("HeirlineModeNormal",    "N?",  "NORMAL (OPERATOR)"),
  noV       = build("HeirlineModeNormal",    "N?",  "NORMAL (OPERATOR)"),
  ["no\22"] = build("HeirlineModeNormal",    "N?",  "NORMAL (OPERATOR)"),

  -- Normal mode with temporary Insert via <C-o>
  niI       = build("HeirlineModeNormal",    "Ni",  "NORMAL (INSERT)"),
  niR       = build("HeirlineModeNormal",    "Nr",  "NORMAL (REPLACE)"),
  niV       = build("HeirlineModeNormal",    "Nv",  "NORMAL (VISUAL)"),

  -- Normal in terminal
  nt        = build("HeirlineModeNormal",    "Nt",  "NORMAL (TERMINAL)"),

  -- Insert mode
  i         = build("HeirlineModeInsert",    "I",   "INSERT"),
  ic        = build("HeirlineModeInsert",    "Ic",  "INSERT (COMPLETION)"),
  ix        = build("HeirlineModeInsert",    "Ix",  "INSERT (COMPLETION)"),

  -- Visual mode
  v         = build("HeirlineModeVisual",    "V",   "VISUAL"),
  vs        = build("HeirlineModeVisual",    "Vs",  "VISUAL"),
  V         = build("HeirlineModeVisual",    "V_",  "VISUAL (LINE)"),
  Vs        = build("HeirlineModeVisual",    "Vs",  "VISUAL (LINE)"),
  ["\22"]   = build("HeirlineModeVisual",    "^V",  "VISUAL (BLOCK)"),
  ["\22s"]  = build("HeirlineModeVisual",    "^V",  "VISUAL (BLOCK)"),

  -- Select mode
  s         = build("HeirlineModeSelection", "S",   "SELECT"),
  S         = build("HeirlineModeSelection", "S_",  "SELECT (LINE)"),
  ["\19"]   = build("HeirlineModeSelection", "^S",  "SELECT (BLOCK)"),

  -- Replace mode
  R         = build("HeirlineModeReplace",   "R",   "REPLACE"),
  Rc        = build("HeirlineModeReplace",   "Rc",  "REPLACE (COMPLETION)"),
  Rx        = build("HeirlineModeReplace",   "Rx",  "REPLACE (COMPLETION)"),
  Rv        = build("HeirlineModeReplace",   "Rv",  "REPLACE (VIRTUAL)"),
  Rvc       = build("HeirlineModeReplace",   "Rv",  "REPLACE (VIRTUAL)"),
  Rvx       = build("HeirlineModeReplace",   "Rv",  "REPLACE (VIRTUAL)"),

  -- Command-line mode
  c         = build("HeirlineModeSpecial",   "C",   "COMMAND"),
  cv        = build("HeirlineModeSpecial",   "Ex",  "EX"),

  -- Other modes
  r         = build("HeirlineModeSpecial",   "...", "PROMPT"),
  rm        = build("HeirlineModeSpecial",   "M",   "MORE"),
  ["r?"]    = build("HeirlineModeSpecial",   "?",   "CONFIRM"),
  ["!"]     = build("HeirlineModeSpecial",   "!",   "SHELL"),
  t         = build("HeirlineModeSpecial",   "T",   "TERMINAL"),
}

local UNKNOWN = build("HeirlineModeSpecial", "***", "UNKNOWN MODE")

return {
  get = function(mode)
    return SPECS[mode] or UNKNOWN
  end
}
