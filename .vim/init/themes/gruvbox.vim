packadd! gruvbox

if exists('g:lightline')
  let g:lightline.colorscheme = 'gruvbox'
endif

" Enables italic text. Default: gui 1, term 0
let g:gruvbox_italic = 1

" Enables transparent background. Default: 0
let g:gruvbox_transparent_bg = 0

" possible values: 'soft', 'medium' (default), and 'hard'
let g:gruvbox_contrast_dark = 'hard'

" possible values: 'soft', 'medium' (default), and 'hard'
let g:gruvbox_contrast_light = 'medium'

set background=dark " Setting dark mode
" set background=light " Setting light mode

syntax enable
colorscheme gruvbox
