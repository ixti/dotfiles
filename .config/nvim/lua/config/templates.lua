local augroup          = vim.api.nvim_create_augroup("NewFileTemplates", { clear = true })
local TEMPLATES_PATH   = vim.fn.stdpath("config") .. "/templates"
local LOADED_TEMPLATES = {}

if vim.fn.isdirectory(TEMPLATES_PATH) == 0 then
  vim.notify("Templates directory not found: " .. TEMPLATES_PATH, vim.log.levels.WARN)
  return
end

local function read_template(filename)
  local cached = LOADED_TEMPLATES[filename]

  if cached then
    return cached
  end

  local file = TEMPLATES_PATH .. "/" .. filename
  if vim.fn.filereadable(file) == 0 then
    vim.notify("Template file missing: " .. file, vim.log.levels.WARN)
    return nil
  end

  local ok, lines = pcall(vim.fn.readfile, file)
  if not ok then
    vim.notify("Error reading template: " .. file, vim.log.levels.ERROR)
    return nil
  end

  LOADED_TEMPLATES[filename] = lines

  return lines
end

local function load_template(buf, filename)
  local lines = read_template(filename)

  if not lines then
    return
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- *** Ruby ********************************************************************

local RUBY_RSPEC_PATTERN = "_spec%.rb$"

vim.api.nvim_create_autocmd("BufNewFile", {
  group    = augroup,
  pattern  = "Gemfile",
  callback = function(ev)
    load_template(ev.buf, "ruby/gemfile.rb")
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  group    = augroup,
  pattern  = "*.rb",
  callback = function(ev)
    if ev.file:match(RUBY_RSPEC_PATTERN) then
      load_template(ev.buf, "ruby/rspec.rb")
    else
      load_template(ev.buf, "ruby.rb")
    end
  end,
})
