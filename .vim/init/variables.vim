" vim: set foldmethod=marker foldlevel=0 nomodeline:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline {{{

let g:lightline =
  \ {
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': { 'lineinfo': ' %3l:%-2v' },
  \   'component_function': { 'gitbranch': 'gina#component#repo#branch' },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' }
  \ }

  "\   'component_function': { 'gitbranch': 'fugitive#head' },

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
