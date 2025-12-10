local keymap     = vim.keymap.set
local nohlsearch = vim.cmd.nohlsearch
local diffupdate = vim.cmd.diffupdate
local redraw     = vim.cmd.redraw

-- <C‑L>: clear search highlighting & refresh diffs.
keymap("n", "<C-l>", function()
  if vim.v.hlsearch == 1 then nohlsearch() end
  if vim.wo.diff         then diffupdate() end

  redraw()
end, { silent = true, desc = "Clear search highlights / refresh diff" })

-- In insert mode, make <C‑U> and <C‑W> create undo breakpoints
-- so backspacing/deleting forms separate undo steps.
keymap("i", "<C-U>", "<C-G>u<C-U>")
keymap("i", "<C-W>", "<C-G>u<C-W>")

-- **** Tab switching **********************************************************

keymap("n", "<C-b>", "<Cmd>tabprev<CR>", { silent = true })
keymap("n", "<C-n>", "<Cmd>tabnext<CR>", { silent = true })

-- **** Visual shifting (stay in Visual mode) **********************************

keymap("v", ">", ">gv", { silent = true })
keymap("v", "<", "<gv", { silent = true })

-- **** Disable arrow keys in normal and insert modes **************************

keymap({ "n", "i" }, "<Up>",    "<Nop>", { silent = true })
keymap({ "n", "i" }, "<Down>",  "<Nop>", { silent = true })
keymap({ "n", "i" }, "<Left>",  "<Nop>", { silent = true })
keymap({ "n", "i" }, "<Right>", "<Nop>", { silent = true })
