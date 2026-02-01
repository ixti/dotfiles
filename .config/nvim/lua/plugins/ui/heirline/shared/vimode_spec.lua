local VimodeSpec = {}
VimodeSpec.__index = VimodeSpec

function VimodeSpec:hl()
  return { fg = "vimode_fg", bg = self.color, bold = true }
end

local KIND = {
  NORMAL          = 1,
  INSERT          = 2,
  VISUAL_CHAR     = 3,
  VISUAL_LINE     = 33,
  VISUAL_BLOCK    = 333,
  SELECTION_CHAR  = 4,
  SELECTION_LINE  = 44,
  SELECTION_BLOCK = 444,
  REPLACE         = 5,
  COMMAND         = 6,
  OTHER           = 7,
  UNKNOWN         = 8,
}

local function build(kind, color, short_name, long_name)
  local self = setmetatable({}, VimodeSpec)

  self.is_normal          = kind == KIND.NORMAL
  self.is_insert          = kind == KIND.INSERT
  self.is_visual_char     = kind == KIND.VISUAL_CHAR
  self.is_visual_line     = kind == KIND.VISUAL_LINE
  self.is_visual_block    = kind == KIND.VISUAL_BLOCK
  self.is_visual          = self.is_visual_char or self.is_visual_line or self.is_visual_block
  self.is_selection_char  = kind == KIND.SELECTION_CHAR
  self.is_selection_line  = kind == KIND.SELECTION_LINE
  self.is_selection_block = kind == KIND.SELECTION_BLOCK
  self.is_selection       = self.is_selection_char or self.is_selection_line or self.is_selection_block
  self.is_replace         = kind == KIND.REPLACE
  self.is_command         = kind == KIND.COMMAND
  self.is_other           = kind == KIND.OTHER
  self.is_unknown         = kind == KIND.UNKNOWN

  self.color              = color
  self.short_name         = short_name
  self.long_name          = long_name

  return self
end

local SPECS = {
  -- Normal
  n         = build(KIND.NORMAL,          "vimode_normal_bg",     "(N)",  "NORMAL"),
  no        = build(KIND.NORMAL,          "vimode_normal_bg",     "N-?",  "NORMAL (OPERATOR)"),
  nov       = build(KIND.NORMAL,          "vimode_normal_bg",     "N-?",  "NORMAL (OPERATOR)"),
  noV       = build(KIND.NORMAL,          "vimode_normal_bg",     "N-?",  "NORMAL (OPERATOR)"),
  ["no\22"] = build(KIND.NORMAL,          "vimode_normal_bg",     "N-?",  "NORMAL (OPERATOR)"),

  -- Normal with temporary Insert via <C-o>
  niI       = build(KIND.NORMAL,          "vimode_normal_bg",     "N-I",  "NORMAL (INSERT)"),
  niR       = build(KIND.NORMAL,          "vimode_normal_bg",     "N-R",  "NORMAL (REPLACE)"),
  niV       = build(KIND.NORMAL,          "vimode_normal_bg",     "N-V",  "NORMAL (VISUAL)"),

  -- Normal in terminal
  nt        = build(KIND.NORMAL,          "vimode_normal_bg",     "N-T",  "NORMAL (TERMINAL)"),

  -- Insert
  i         = build(KIND.INSERT,          "vimode_insert_bg",     "(I)",  "INSERT"),
  ic        = build(KIND.INSERT,          "vimode_insert_bg",     "I-C",  "INSERT (COMPLETION)"),
  ix        = build(KIND.INSERT,          "vimode_insert_bg",     "I-X",  "INSERT (COMPLETION)"),

  -- Visual
  v         = build(KIND.VISUAL_CHAR,     "vimode_visual_bg",     "(V)",  "VISUAL"),
  vs        = build(KIND.VISUAL_CHAR,     "vimode_visual_bg",     "(V)",  "VISUAL"),
  V         = build(KIND.VISUAL_LINE,     "vimode_visual_bg",     "V-L",  "VISUAL (LINE)"),
  Vs        = build(KIND.VISUAL_LINE,     "vimode_visual_bg",     "V-L",  "VISUAL (LINE)"),
  ["\22"]   = build(KIND.VISUAL_BLOCK,    "vimode_visual_bg",     "V-B",  "VISUAL (BLOCK)"),
  ["\22s"]  = build(KIND.VISUAL_BLOCK,    "vimode_visual_bg",     "V-B",  "VISUAL (BLOCK)"),

  -- Select
  s         = build(KIND.SELECTION_CHAR,  "vimode_selection_bg",  "(S)",  "SELECT"),
  S         = build(KIND.SELECTION_LINE,  "vimode_selection_bg",  "S-L",  "SELECT (LINE)"),
  ["\19"]   = build(KIND.SELECTION_BLOCK, "vimode_selection_bg",  "S-B",  "SELECT (BLOCK)"),

  -- Replace
  R         = build(KIND.REPLACE,         "vimode_replace_bg",    "(R)",  "REPLACE"),
  Rc        = build(KIND.REPLACE,         "vimode_replace_bg",    "R-C",  "REPLACE (COMPLETION)"),
  Rx        = build(KIND.REPLACE,         "vimode_replace_bg",    "R-X",  "REPLACE (COMPLETION)"),
  Rv        = build(KIND.REPLACE,         "vimode_replace_bg",    "R-V",  "REPLACE (VIRTUAL)"),
  Rvc       = build(KIND.REPLACE,         "vimode_replace_bg",    "R-V",  "REPLACE (VIRTUAL)"),
  Rvx       = build(KIND.REPLACE,         "vimode_replace_bg",    "R-V",  "REPLACE (VIRTUAL)"),

  -- Command-line
  c         = build(KIND.COMMAND,         "vimode_special_bg",    "(C)",  "COMMAND"),
  cv        = build(KIND.COMMAND,         "vimode_special_bg",    "(X)",  "EX"),

  -- Other
  r         = build(KIND.OTHER,           "vimode_special_bg",    "(>)",  "PROMPT"),
  rm        = build(KIND.OTHER,           "vimode_special_bg",    "(M)",  "MORE"),
  ["r?"]    = build(KIND.OTHER,           "vimode_special_bg",    "(?)",  "CONFIRM"),
  ["!"]     = build(KIND.OTHER,           "vimode_special_bg",    "(!)",  "SHELL"),
  t         = build(KIND.OTHER,           "vimode_special_bg",    "(T)",  "TERMINAL"),
}

return {
  get = function(mode)
    return SPECS[mode] or build(KIND.UNKNOWN, "vimode_special_bg", "***", "UNKNOWN MODE")
  end
}
