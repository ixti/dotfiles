" NERDTree
if exists('loaded_nerd_tree')
    let NERDTreeWinSize=35
    nmap <silent> <F2> :NERDTreeToggle<CR>
    imap <silent> <F2> <Esc>:NERDTreeFind<CR>
endif
