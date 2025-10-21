local M = {}

-- Clear search highlights and refresh diff
function M.clear_search_highlight_and_refresh_diff()
  if vim.v.hlsearch == 1 then
    vim.cmd.nohlsearch()
  end

  if vim.wo.diff then
    vim.cmd.diffupdate()
  end

  -- Redraw the screen (same as pressing Ctrl‑L)
  vim.cmd.redraw()
end

return M
