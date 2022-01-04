packadd! jellybeans

let g:jellybeans_use_lowcolor_black = 0
let g:jellybeans_use_term_italics = 1

let g:jellybeans_overrides = {
  \ 'background': { 'ctermbg': 'NONE', '256ctermbg': 'NONE' },
  \ }

let g:airline_theme = 'jellybeans'

syntax enable
colorscheme jellybeans

" NOTE: This needs to go after colorscheme setup
" fix background for terminals (i want transparency)
" https://github.com/vim/vim/issues/993
" if !has('gui_running')
"   hi! Normal ctermbg=NONE guibg=NONE
"   hi! NonText ctermbg=NONE guibg=NONE
" endif
