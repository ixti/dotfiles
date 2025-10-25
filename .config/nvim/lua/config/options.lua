local opt = vim.opt

-- ****  Navigation & Scrolling  ************************************************

-- Keep a few context lines visible above/below cursor while scrolling.
opt.scrolloff = 3

-- Keep small horizontal margin when side‑scrolling long lines.
opt.sidescrolloff = 2

-- This provides smoother horizontal and vertical scrolling in compatible UIs.
-- But can (and does) add rendering overhead depending on terminal or GUI frontend
-- (like kitty or wezterm). Thus, disabling it.
opt.smoothscroll = false

-- Disbale mouse interactions
opt.mouse = ""


-- **** Whitespace & Indentation ***********************************************

-- Use spaces instead of literal tab characters.
opt.expandtab = true

-- Set visible width of a hard tab; rarely used once expandtab=true.
opt.tabstop = 4

-- Two‑space indentation width for coding (fits common Lua/Ruby style).
opt.shiftwidth = 2

-- Ensure shifting (> or <) snaps to multiples of shiftwidth.
opt.shiftround = true

-- Follows shiftwidth automatically.
opt.softtabstop = -1

-- Context‑aware indentation.
opt.smartindent = true

-- Hard-wrap on 81st character by default
opt.textwidth = 80


-- ****  UI / Display  *********************************************************

-- Always show absolute line numbers (easy to toggle to hybrid later).
opt.number = true

-- Highlight current line to track cursor location.
opt.cursorline = true

-- Do not highlight cursor's column as it leads to huge performance issues ((
opt.cursorcolumn = false

-- Visually mark 81s column.
opt.colorcolumn = "81,121"

-- Show non‑printing characters to spot stray spaces/tabs.
opt.list = true
opt.listchars = { tab = "> ", trail = "-", extends = ">", precedes = "<", nbsp = "+" }

-- Never wrap long lines; horizontal scrolling is clearer for code.
opt.wrap = false

-- Display as much of the final line as possible even if long.
opt.display:append({ "lastline", "truncate" })

-- Always show signs (LSP/gitsigns)
opt.signcolumn = "yes:2"

-- Don't conceal anything!!! (like ``` in markdown)
opt.conceallevel = 0

-- Ensure modern color support.
opt.termguicolors = true


-- ****  Command / Search  *****************************************************

-- Preview substitutions live.
opt.inccommand = "split"

-- Smart command‑line completion:
--  First <Tab>: list matches & insert longest prefix;
--  Second <Tab>: cycle through full matches.
opt.wildmode = { "list:longest", "full" }

-- Make search case‑insensitive unless capital letters are used.
opt.ignorecase = true
opt.smartcase  = true

-- Update asynchronous UI feedback (diagnostics/git) quickly.
opt.updatetime = 100

-- Keep command history depth manageable.
opt.history = 1000


-- ****  Session / File Handling  **********************************************

opt.swapfile   = false
opt.undofile   = true
opt.undolevels = 10000

-- Don’t persist local options/keymaps inside session or view files;
-- avoids polluting project sessions with personal prefs.
opt.sessionoptions:remove("options")
opt.viewoptions:remove("options")


-- ****  Tweaks & Optimizations  ***********************************************

opt.timeoutlen  = 400 -- Faster keymap recognition
opt.ttimeoutlen = 10  -- How long Neovim waits for the rest of an escape sequence
