packadd! gruvbox8

if exists('g:lightline')
  let g:lightline.colorscheme = 'gruvbox8'
endif

let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1

let g:gruvbox_italics = 1
let g:gruvbox_italicize_strings = 0

" Enables transparent background. Default: 0
let g:gruvbox_transp_bg = 0

set background=dark " Setting dark mode
" set background=light " Setting light mode

syntax enable
colorscheme gruvbox8_hard
