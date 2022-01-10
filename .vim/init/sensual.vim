runtime OPT plugin/sensible.vim

" Display non-printable characters
set list

" Allow set config per-file with special modelines
set modeline

" Insert mode completion options
set completeopt=menu,longest,preview

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Use F10 to toggle 'paste' mode
set pastetoggle=<F10>

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 2 spaces for (auto)indent
set shiftwidth=2

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Use 4 spaces for <Tab> and :retab
set tabstop=4

" Write swap file to disk after every 50 characters
set updatecount=50

" default updatetime 4000ms is not good for async update
" see: https://github.com/mhinz/vim-signify#configuration-for-async-update
set updatetime=100

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
" set viminfo='20,\"50,:20,%,n~/.viminfo

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

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

" Highlight current row/col
set cursorline
set cursorcolumn
