" vim: set foldmethod=marker foldlevel=0 nomodeline:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ruby.vim (https://github.com/vim-ruby/vim-ruby)

let g:ruby_operators        = 1
let g:ruby_pseudo_operators = 1

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
" asciidoctor {{{

" List of filetypes to highlight, default `[]`
let g:asciidoctor_fenced_languages = [ 'bash', 'css', 'html', 'python', 'ruby', 'sql' ]

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" surrounding {{{

let g:surround_{char2nr("*")} = "/* \r */"

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
