vim.diagnostic.config({
  virtual_lines    = false,
  virtual_text     = { current_line = true, hl_mode = "combine" },
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = { border = "rounded" },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
})
