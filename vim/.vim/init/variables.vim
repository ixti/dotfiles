" vim: set foldmethod=marker foldlevel=0 nomodeline:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline {{{

let g:airline_theme           = 'jellybeans'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = '*'

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf.vim (https://github.com/junegunn/fzf.vim) {{{

" Prefix commands with `Fzf`, e.g. `FzfFiles`, `FzfHistory`, etc.
let g:fzf_command_prefix = 'Fzf'

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf-mru (https://github.com/pbogut/fzf-mru.vim) {{{

" Only list files within current directory.
let g:fzf_mru_relative = 1

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown {{{

let g:markdown_fenced_languages = [ 'bash=sh', 'css', 'html', 'python', 'ruby', 'sass', 'scss', 'sql', 'zsh' ]

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surrounding {{{

let g:surround_{char2nr("*")} = "/* \r */"

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
