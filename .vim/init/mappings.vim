" tab switching
map <C-b> :tabprev<CR>
map <C-n> :tabnext<CR>

" Tab-management
nmap <Leader>tt :tabnew<CR>
nmap <Leader>to :tabnew<Space>
nmap <Leader>tw :tabnew %<CR>
nmap <Leader>tc :tabclose<CR>

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
