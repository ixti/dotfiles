vim9script

if exists("g:lightline")
  g:lightline.colorscheme = "gruvbox"
endif

# Enables italic text. Default: gui 1, term 0
g:gruvbox_italic = 1

# Enables transparent background. Default: 0
g:gruvbox_transparent_bg = 0

# possible values: 'soft', 'medium' (default), and 'hard'
g:gruvbox_contrast_dark = "hard"

# possible values: 'soft', 'medium' (default), and 'hard'
g:gruvbox_contrast_light = "medium"

set background=dark

syntax      enable
colorscheme gruvbox
