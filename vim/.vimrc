runtime init/pathogen.vim
runtime init/neocomplete.vim


"
" MAIN CUSTOMIZATION FILE
"


" Enable loading filetype and indentation plugins
filetype plugin indent on

" Turn syntax highlighting on
syntax on


"
" GLOBAL SETTINGS
"


" Allow set config per-file with special modelines
set modeline

" Allow backspacing over everything
set backspace=indent,eol,start

" Insert mode completion options
set completeopt=menu,longest,preview

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Remember up to 32 'colon' commmands and search patterns
set history=32

" Enable incremental search
set incsearch

" Always show status line, even for one window
set laststatus=2

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Don't highlight results of a search
set nohlsearch

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Use F10 to toggle 'paste' mode
set pastetoggle=<F10>

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 2 spaces for (auto)indent
set shiftwidth=2

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Don't request terminal version string (for xterm)
set t_RV=

" Use 4 spaces for <Tab> and :retab
set tabstop=2

" Write swap file to disk after every 50 characters
set updatecount=50

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Disable vi-compatibiliness
set nocompatible

" Copy indent from current line when starting a new line
set autoindent

" Use the appropriate number of spaces to insert a <Tab>
set expandtab

" Show line numbers
set number

" Do not wrap lines
set nowrap

" Set maximum text width
set textwidth=80

" Highlight textwidth+1 char column
set colorcolumn=+1

" Highlight special chars
set list
set listchars=tab:~>,trail:~,nbsp:#

" Highlight current row/col
set cursorline
set cursorcolumn


"
" TERM HACKS
"


if &term =~ "xterm" || &term =~ "screen"
  if has("terminfo")
    set t_Co=256
    set t_Sf=<Esc>[3%p1%dm
    set t_Sb=<Esc>[4%p1%dm
  else
    set t_Co=8
    set t_Sf=<Esc>[3%dm
    set t_Sb=<Esc>[4%dm
  endif
endif


"
" GUI CONFIG
"


if has('gui_running')
    " Fix window height of gui
    set lines=52
    set guioptions=
    set guifont=DejaVu\ Sans\ Mono\ 11
endif


"
" MAPPINGS
"


" Set the <Leader> for combo commands
let mapleader = ","

" tab switching
map <C-b> :tabprev<CR>
map <C-n> :tabnext<CR>

" switch to upper/lower window quickly
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" visual shifting (does not exit Visual mode)
vnoremap > >gv
vnoremap < <gv

" Shorthand syntax to work with X clipboard
nmap <Leader>y "+y
nmap <Leader>Y "+Y
nmap <Leader>p "+p
nmap <Leader>P "+P

" tabs management
nmap t :tabnew

" disable up/down/left/right
map <Up>    <Nop>
map <Down>  <Nop>
map <Left>  <Nop>
map <Right> <Nop>

imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>

imap <F7> <C-o>:setlocal spell! spelllang=en,ru<CR>
nmap <F7> :setlocal spell! spelllang=en,ru<CR>

" Set awesome colorscheme :))
colorscheme jellybeans


" Enable transparency for term colors
function TransparencifyColorscheme()
  hi Normal  ctermbg=none
  hi NonText ctermbg=none
endfunction

if !empty($TERMINATOR_UUID) || &term =~ "rxvt"
  call TransparencifyColorscheme()
endif
