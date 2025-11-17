local M = {}

function ensure_lazy_loaded(name)
  local lazy    = require("lazy")
  local plugins = lazy.plugins()

  if plugins[name] and plugins[name].loaded then
    return
  end

  lazy.load({ plugins = { name } })
end

function M.git_root_or_cwd()
  ensure_lazy_loaded("vim-fugitive")

  local git_root = vim.fn.FugitiveWorkTree()

  if git_root and git_root ~= "" then
    return git_root
  end

  return vim.fn.getcwd()
end

return M
