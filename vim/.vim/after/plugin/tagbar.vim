nmap <silent> <Leader>8 :TagbarToggle<CR>


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
