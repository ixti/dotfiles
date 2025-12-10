vim.diagnostic.config({
  virtual_lines    = false,
  virtual_text     = { current_line = true, hl_mode = "combine" },
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = { border = "rounded" },
})
