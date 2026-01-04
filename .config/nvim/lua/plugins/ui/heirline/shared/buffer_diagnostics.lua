local M = {}

local nvim_buf_is_valid    = vim.api.nvim_buf_is_valid
local nvim_get_current_buf = vim.api.nvim_get_current_buf

local function normalize_bufnr(bufnr)
  if bufnr == nil then bufnr = nvim_get_current_buf() end
  if nvim_buf_is_valid(bufnr) then return bufnr end
end

local SEV_ERROR = vim.diagnostic.severity.ERROR
local SEV_WARN  = vim.diagnostic.severity.WARN
local SEV_HINT  = vim.diagnostic.severity.HINT
local SEV_INFO  = vim.diagnostic.severity.INFO

local function build_stats(diagnostics)
  local errors, warnings, hints, infos = 0, 0, 0, 0

  for _, diag in ipairs(diagnostics) do
    if     diag.severity == SEV_ERROR then errors   = errors + 1
    elseif diag.severity == SEV_WARN  then warnings = warnings + 1
    elseif diag.severity == SEV_HINT  then hints    = hints + 1
    elseif diag.severity == SEV_INFO  then infos    = infos + 1
    end
  end

  return {
    errors   = errors,
    warnings = warnings,
    hints    = hints,
    infos    = infos,
  }
end

local function equal_stats(old, new)
  if not old then return false end

  if     old.errors   ~= new.errors   then return false
  elseif old.warnings ~= new.warnings then return false
  elseif old.hints    ~= new.hints    then return false
  elseif old.infos    ~= new.infos    then return false
  end

  return true
end

local function reset_stats(bufnr)
  local stats = build_stats(vim.diagnostic.get(bufnr))
  local buf   = vim.b[bufnr]

  if not equal_stats(buf.heirline_buffer_diagnostics, stats) then
    buf.heirline_buffer_diagnostics = stats
  end

  return stats
end

function M.get(bufnr)
  bufnr = normalize_bufnr(bufnr)

  if not bufnr then
    return {
      errors   = 0,
      warnings = 0,
      hints    = 0,
      infos    = 0,
    }
  end

  return vim.b[bufnr].heirline_buffer_diagnostics or reset_stats(bufnr)
end

function M.clear(bufnr)
  vim.b[bufnr].heirline_buffer_diagnostics = nil
end

function M.reset(bufnr)
  bufnr = normalize_bufnr(bufnr)
  if not bufnr then return end

  reset_stats(bufnr)
end

return M
