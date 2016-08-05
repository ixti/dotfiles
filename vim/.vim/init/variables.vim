"" markdown """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:markdown_fenced_languages = [ 'html', 'css', 'scss', 'sass', 'ruby', 'python', 'zsh', 'bash=sh']


"" airline """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme           = "jellybeans"
let g:airline_powerline_fonts = 1


"" syntastic """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['eslint']


"" taglist """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Tlist_Display_Prototype       = 1
let Tlist_Exit_OnlyWindow         = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File           = 1
let Tlist_Sort_Type               = "name"
let Tlist_Use_Right_Window        = 1


"" jellybeans """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:jellybeans_use_term_background_color = 1
let g:jellybeans_use_lowcolor_black = 0
let g:jellybeans_use_term_italics = 0
