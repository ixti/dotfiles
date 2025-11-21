local keymap = vim.keymap.set

-- <C‑L>: clear search highlighting & refresh diffs.
keymap("n", "<C-l>", require("utils.editor").clear_search_highlight_and_refresh_diff, {
  silent = true,
  desc   = "Clear search highlights / refresh diff"
})

-- In insert mode, make <C‑U> and <C‑W> create undo breakpoints
-- so backspacing/deleting forms separate undo steps.
keymap("i", "<C-U>", "<C-G>u<C-U>")
keymap("i", "<C-W>", "<C-G>u<C-W>")

-- **** Tab switching **********************************************************

keymap("n", "<C-b>", "<Cmd>tabprev<CR>", { silent = true })
keymap("n", "<C-n>", "<Cmd>tabnext<CR>", { silent = true })

-- **** Tab management *********************************************************

keymap("n", "<Leader>tt", "<Cmd>tabnew<CR>",   { silent = true })
keymap("n", "<Leader>tw", "<Cmd>tabnew %<CR>", { silent = true })
keymap("n", "<Leader>tc", "<Cmd>tabclose<CR>", { silent = true })


-- **** Visual shifting (stay in Visual mode) **********************************

keymap("v", ">", ">gv", { silent = true })
keymap("v", "<", "<gv", { silent = true })


-- **** Disable arrow keys in normal and insert modes **************************

for _, mode in ipairs({ "n", "i" }) do
  local opts = { silent = true }

  keymap(mode, "<Up>",    "<Nop>", opts)
  keymap(mode, "<Down>",  "<Nop>", opts)
  keymap(mode, "<Left>",  "<Nop>", opts)
  keymap(mode, "<Right>", "<Nop>", opts)
end
