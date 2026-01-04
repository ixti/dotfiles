local VimodeSpec = {}
VimodeSpec.__index = VimodeSpec

function VimodeSpec:hl()
  return { fg = "vimode_fg", bg = self.color, bold = true }
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
  n         = build("vimode_normal_bg",    "N",   "NORMAL"),
  no        = build("vimode_normal_bg",    "N?",  "NORMAL (OPERATOR)"),
  nov       = build("vimode_normal_bg",    "N?",  "NORMAL (OPERATOR)"),
  noV       = build("vimode_normal_bg",    "N?",  "NORMAL (OPERATOR)"),
  ["no\22"] = build("vimode_normal_bg",    "N?",  "NORMAL (OPERATOR)"),

  -- Normal mode with temporary Insert via <C-o>
  niI       = build("vimode_normal_bg",    "Ni",  "NORMAL (INSERT)"),
  niR       = build("vimode_normal_bg",    "Nr",  "NORMAL (REPLACE)"),
  niV       = build("vimode_normal_bg",    "Nv",  "NORMAL (VISUAL)"),

  -- Normal in terminal
  nt        = build("vimode_normal_bg",    "Nt",  "NORMAL (TERMINAL)"),

  -- Insert mode
  i         = build("vimode_insert_bg",    "I",   "INSERT"),
  ic        = build("vimode_insert_bg",    "Ic",  "INSERT (COMPLETION)"),
  ix        = build("vimode_insert_bg",    "Ix",  "INSERT (COMPLETION)"),

  -- Visual mode
  v         = build("vimode_visual_bg",    "V",   "VISUAL"),
  vs        = build("vimode_visual_bg",    "Vs",  "VISUAL"),
  V         = build("vimode_visual_bg",    "V_",  "VISUAL (LINE)"),
  Vs        = build("vimode_visual_bg",    "Vs",  "VISUAL (LINE)"),
  ["\22"]   = build("vimode_visual_bg",    "^V",  "VISUAL (BLOCK)"),
  ["\22s"]  = build("vimode_visual_bg",    "^V",  "VISUAL (BLOCK)"),

  -- Select mode
  s         = build("vimode_selection_bg", "S",   "SELECT"),
  S         = build("vimode_selection_bg", "S_",  "SELECT (LINE)"),
  ["\19"]   = build("vimode_selection_bg", "^S",  "SELECT (BLOCK)"),

  -- Replace mode
  R         = build("vimode_replace_bg",   "R",   "REPLACE"),
  Rc        = build("vimode_replace_bg",   "Rc",  "REPLACE (COMPLETION)"),
  Rx        = build("vimode_replace_bg",   "Rx",  "REPLACE (COMPLETION)"),
  Rv        = build("vimode_replace_bg",   "Rv",  "REPLACE (VIRTUAL)"),
  Rvc       = build("vimode_replace_bg",   "Rv",  "REPLACE (VIRTUAL)"),
  Rvx       = build("vimode_replace_bg",   "Rv",  "REPLACE (VIRTUAL)"),

  -- Command-line mode
  c         = build("vimode_special_bg",   "C",   "COMMAND"),
  cv        = build("vimode_special_bg",   "Ex",  "EX"),

  -- Other modes
  r         = build("vimode_special_bg",   "...", "PROMPT"),
  rm        = build("vimode_special_bg",   "M",   "MORE"),
  ["r?"]    = build("vimode_special_bg",   "?",   "CONFIRM"),
  ["!"]     = build("vimode_special_bg",   "!",   "SHELL"),
  t         = build("vimode_special_bg",   "T",   "TERMINAL"),
}

local UNKNOWN = build("vimode_special_bg", "***", "UNKNOWN MODE")

return {
  get = function(mode)
    return SPECS[mode] or UNKNOWN
  end
}
