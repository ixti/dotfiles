vim9script

g:fern#disable_default_mappings = 1
g:fern#hide_cursor              = 1
g:fern#keepalt_on_edit          = 1
g:fern#default_hidden           = 0

augroup FernInit
  def ConfigureFern(): void
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

    nmap <buffer> ! <Plug>(fern-action-hidden:toggle)

    nmap <buffer> ma <Plug>(fern-action-new-path)
    nmap <buffer> mc <Plug>(fern-action-copy)
    nmap <buffer> md <Plug>(fern-action-remove)
    nmap <buffer> mm <Plug>(fern-action-move)
    nmap <buffer> mM <Plug>(fern-action-rename)

    nmap <buffer> <Space> <Plug>(fern-action-mark:toggle)

    nmap <buffer><nowait> s <Plug>(fern-my-action-open:split)
    nmap <buffer><nowait> v <Plug>(fern-my-action-open:vsplit)
    nmap <buffer>         t <Plug>(fern-action-open:tabedit)

    nmap <buffer> r <Plug>(fern-action-reload)

    nmap <buffer> q :<C-u>quit<CR>

    nmap <buffer><nowait> < <Plug>(fern-action-leave)
    nmap <buffer><nowait> > <Plug>(fern-action-enter)
  enddef

  autocmd! *
  autocmd FileType fern ConfigureFern()
augroup END

nnoremap <silent> <Leader>e :<C-u>Fern <C-r>=fnameescape(fnamemodify('.', ':p'))<CR> -drawer -toggle<CR>
nnoremap <silent> <Leader>E :<C-u>Fern <C-r>=fnameescape(fnamemodify('.', ':p'))<CR> -drawer -toggle -reveal=%:p<CR>
