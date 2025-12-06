local group          = vim.api.nvim_create_augroup("NewFileTemplates", { clear = true })
local templates_path = vim.fn.stdpath("config") .. "/templates"

local function read_template(filename)
  local path = templates_path .. "/" .. filename
  local ok, lines = pcall(vim.fn.readfile, path)

  if not ok then
    vim.notify("Template not found: " .. filename, vim.log.levels.WARN)
    return {}
  end

  return lines
end

local function register_template(pattern, filename)
  local template = nil

  vim.api.nvim_create_autocmd("BufNewFile", {
    group   = group,
    pattern = pattern,
    callback = function(ev)
      if not template then
        template = read_template(filename)
      end

      vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, template)
    end,
  })
end

-- Order in less specific to more specific pattern
register_template("*.rb",      "ruby.rb")
register_template("*_spec.rb", "ruby/rspec.rb")
