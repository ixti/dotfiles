local opt = vim.opt

-- ============================================================================
-- Navigation & Scrolling
-- ============================================================================

-- Keep 3 context lines visible above/below cursor while scrolling
-- Prevents cursor from touching screen edges during vertical navigation
opt.scrolloff = 3

-- Keep 6 columns visible when horizontally scrolling long lines
-- Provides context when navigating lines wider than the window
opt.sidescrolloff = 6

-- Smooth scrolling can cause performance issues in some terminals (kitty, wezterm)
-- Disabled to prioritize rendering speed over animation smoothness
opt.smoothscroll = false

-- Disable all mouse interactions (keyboard-only workflow)
-- Remove this line if you prefer mouse support for clicking, scrolling, etc.
opt.mouse = ""

-- Open vertical splits to the right (instead of left)
opt.splitright = true

-- Open horizontal splits below (instead of above)
opt.splitbelow = true

-- ============================================================================
-- Whitespace & Indentation
-- ============================================================================

-- Convert Tab key to spaces (prevents mixed indentation issues)
opt.expandtab = true

-- Width of actual tab character when displayed (only matters for existing tabs)
-- Set to 4 to match common convention for viewing legacy code
opt.tabstop = 4

-- Number of spaces for each indentation level (affects >>, <<, and auto-indent)
-- 2 spaces is standard for Lua, Ruby, and many modern languages
opt.shiftwidth = 2

-- Round indentation to nearest multiple of shiftwidth when using < or >
-- Prevents uneven indentation when shifting blocks
opt.shiftround = true

-- Number of spaces inserted when pressing Tab in insert mode
-- `-1` means "follow shiftwidth automatically"
opt.softtabstop = -1

-- Enable context-aware auto-indentation (recognizes brackets, braces, etc.)
opt.smartindent = true

-- Automatically hard-wrap lines at 80 characters
-- Common limit for code readability and commit message conventions
opt.textwidth = 80

-- ============================================================================
-- UI & Display
-- ============================================================================

-- Show absolute line numbers in the gutter on the current line,
-- and relative numbers before/after it.
opt.number         = true
opt.relativenumber = true

-- Highlight the current line to make cursor location more visible
opt.cursorline = true

-- Disable column highlighting (can cause severe performance degradation)
opt.cursorcolumn = false

-- Draw vertical rulers at columns 81 and 121
-- 80 is standard limit; 121 marks extended tolerance for long lines
opt.colorcolumn = "81,121"

-- Display invisible characters to catch trailing spaces and mixed indentation
opt.list = true
opt.listchars = {
  tab      = "> ", -- Show tabs as "> "
  trail    = "-",  -- Show trailing spaces as "-"
  extends  = ">",  -- Show ">" when line continues beyond right edge
  precedes = "<",  -- Show "<" when line continues beyond left edge
  nbsp     = "+",  -- Show non-breaking spaces as "+"
}

-- Disable line wrapping (horizontal scrolling is clearer for code)
-- Long lines stay on one line; use sidescroll to navigate
opt.wrap = false

-- When last line is too long to fit, show as much as possible instead of "@@@"
opt.display:append({ "lastline", "truncate" })

-- Always show sign column with space for 2 signs (LSP diagnostics, git changes, etc.)
-- Prevents UI jumping when signs appear/disappear
opt.signcolumn = "yes:2"

-- Never conceal syntax elements (prevents hiding ``` block surroundings)
-- Set to 2 or 3 if you want concealment in specific filetypes
opt.conceallevel = 0

-- Enable 24-bit RGB colors in terminal (required for modern color schemes)
opt.termguicolors = true

-- Show live preview of substitutions in a split window
-- Useful for verifying :%s/foo/bar/g before executing
opt.inccommand = "split"

-- Default border style of floating windows
opt.winborder = "rounded"

-- ============================================================================
-- Search Behaviour
-- ============================================================================

-- Make searches case-insensitive by default
opt.ignorecase = true

-- Override ignorecase when search pattern contains uppercase letters
-- Enables smart case-sensitive search (e.g., /Foo matches only "Foo", not "foo")
opt.smartcase = true

-- ============================================================================
-- Command Line & Completion
-- ============================================================================

-- Command-line completion behavior:
--   First <Tab>: show all matches and complete longest common prefix
--   Subsequent <Tab>: cycle through full matches
opt.wildmode = { "list:longest", "full" }

-- Store up to 1000 commands in history (:history to view)
opt.history = 1000

-- ============================================================================
-- Session & File Handling
-- ============================================================================

-- Disable swap files (can cause issues with file watchers and git)
-- Rely on undofile for recovery instead
opt.swapfile = false

-- Enable persistent undo (survives closing and reopening files)
-- Undo history stored in ~/.local/state/nvim/undo/
opt.undofile = true

-- Maximum number of changes that can be undone
opt.undolevels = 10000

-- Don't save local options/keymaps in session files
-- Prevents personal preferences from leaking into shared project sessions
opt.sessionoptions:remove("options")

-- Don't save local options/keymaps in view files (created by mkview)
opt.viewoptions:remove("options")

-- ============================================================================
-- Performance & Responsiveness
-- ============================================================================

-- Trigger CursorHold events and swap file writes after 100ms of inactivity
-- Faster feedback for LSP diagnostics, git signs, and auto-save plugins
opt.updatetime = 100

-- Time (ms) Neovim waits for next key in a mapped sequence (e.g., <leader>ff)
-- Lower = faster response but less time to complete multi-key bindings
opt.timeoutlen = 400

-- Time (ms) Neovim waits for escape sequences from the terminal
-- Lower = faster escape key response in terminal emulators
opt.ttimeoutlen = 10
