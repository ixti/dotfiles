nmap <silent> 8 :TagbarToggle<CR>
imap <silent> 8 <Esc>:TagbarToggle<CR>


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
