vim9script

packadd! gruvbox8

if exists("g:lightline")
  g:lightline.colorscheme = "gruvbox8"
endif

g:gruvbox_filetype_hi_groups = 1
g:gruvbox_plugin_hi_groups = 1

g:gruvbox_italics = 1
g:gruvbox_italicize_strings = 0

# Enables transparent background. Default: 0
g:gruvbox_transp_bg = 0

set background=dark

syntax enable
colorscheme gruvbox8_hard
