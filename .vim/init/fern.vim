" Disable netrw.
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden           = 0

nnoremap <silent> <Leader>e :Fern %:h -drawer -toggle<CR>
nnoremap <silent> <Leader>E :Fern %:h -drawer -toggle -reveal=%<CR>

function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-action-open-or-expand)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:edit-or-split)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer><expr>
    \ <Plug>(fern-my-action-open:split)
    \ fern#smart#leaf(
    \   "<Plug>(fern-action-open:split)",
    \   ""
    \ )

  nmap <buffer><expr>
    \ <Plug>(fern-my-action-open:vsplit)
    \ fern#smart#leaf(
    \   "<Plug>(fern-action-open:vsplit)",
    \   ""
    \ )

  nmap <buffer><nowait> <CR> <Plug>(fern-my-action-open-or-expand)
  nmap <buffer><nowait> o <Plug>(fern-my-action-open-or-expand)

  nmap <buffer> ! <Plug>(fern-action-hidden:toggle)

  nmap <buffer> ma <Plug>(fern-action-new-path)
  nmap <buffer> mc <Plug>(fern-action-copy)
  nmap <buffer> md <Plug>(fern-action-remove)
  nmap <buffer> mm <Plug>(fern-action-move)
  nmap <buffer> mM <Plug>(fern-action-rename)

  nmap <buffer> <Space> <Plug>(fern-action-mark:toggle)j

  nmap <buffer><nowait> s <Plug>(fern-my-action-open:split)
  nmap <buffer><nowait> v <Plug>(fern-my-action-open:vsplit)
  nmap <buffer>         t <Plug>(fern-action-open:tabedit)

  nmap <buffer> r <Plug>(fern-action-reload)

  nmap <buffer> q :<C-u>quit<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup my-fern
  autocmd! *
  autocmd FileType fern setlocal norelativenumber | setlocal nonumber | call s:init_fern()
augroup END
