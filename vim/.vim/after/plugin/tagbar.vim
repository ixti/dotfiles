nmap <silent> <F8> :TagbarToggle<CR>
imap <silent> <F8> <Esc>:TagbarToggle<CR>


let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'f:methods',
        \ 'F:singleton methods',
        \ 'd:rspec describe',
        \ 'C:rspec context',
    \ ],
\ }
