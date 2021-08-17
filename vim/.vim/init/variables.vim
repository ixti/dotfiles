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
" jellybeans {{{

let g:jellybeans_use_lowcolor_black = 0
let g:jellybeans_use_term_italics = 1

let g:jellybeans_overrides = {
  \ 'background': { 'ctermbg': 'NONE', '256ctermbg': 'NONE' },
  \ }

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown {{{

let g:markdown_fenced_languages = [ 'bash=sh', 'css', 'html', 'python', 'ruby', 'sass', 'scss', 'sql', 'zsh' ]

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic {{{

let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['eslint']

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist {{{

let Tlist_Display_Prototype       = 1
let Tlist_Exit_OnlyWindow         = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File           = 1
let Tlist_Sort_Type               = 'name'
let Tlist_Use_Right_Window        = 1

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
