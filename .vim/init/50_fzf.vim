vim9script

# fzf.vim <https://github.com/junegunn/fzf.vim>
################################################################################

g:fzf_command_prefix = "Fzf"

nnoremap <silent> <expr> <Leader>ff ":" .. g:fzf_command_prefix .. "Files\<CR>"
nnoremap <silent> <expr> <Leader>fr ":" .. g:fzf_command_prefix .. "Rg\<CR>"
nnoremap <silent> <expr> <Leader>fh ":" .. g:fzf_command_prefix .. "History\<CR>"
nnoremap <silent> <expr> <Leader>fb ":" .. g:fzf_command_prefix .. "Buffer\<CR>"
nnoremap <silent> <expr> <Leader>ft ":" .. g:fzf_command_prefix .. "Tags\<CR>"
nnoremap <silent> <expr> <Leader>f/ ":" .. g:fzf_command_prefix .. "BLines\<CR>"

# fzf-mru <https://github.com/pbogut/fzf-mru.vim>
################################################################################

g:fzf_mru_relative = 1

nnoremap <silent> <Leader>fm :FZFMru<CR>
