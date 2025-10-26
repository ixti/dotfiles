local M = {}

function M.git_root_or_fallback(fallback)
  local cwd = vim.fn.getcwd()

  local ok, git2 = pcall(require, "fugit2.core.git2")

  if not ok then
    vim.notify("fugit2.core.git2 not found", vim.log.levels.WARN)

    -- Potentially can fallback to pure git calls, but as I'm using Fugit2 atm
    -- not going to build wunderwaffle for no good reason.
  else
    local repo, _ = git2.Repository.open(cwd, true)

    if repo then
      return repo:workdir()
    end
  end

  return fallback or cwd
end

return M
