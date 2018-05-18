if has('gui_running')
    set guioptions=""
    set guifont=Monospace\ 12
endif

colorscheme jellybeans

" fix background for terminals (i want transparency)
" https://github.com/vim/vim/issues/993
if !has('gui_running')
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
endif
