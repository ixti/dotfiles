function! s:AckSelected() abort
  " preserve @@ register
  let reg_save = @@

  " copy selected text to @@ register
  silent exe "normal! `<v`>y"

  " escape special chars,
  " % is file name in vim we need to escape that first
  " # is secial in ag/ack
  let escaped_for_ack = escape(@@, '%#')
  let escaped_for_ack = escape(escaped_for_ack, '#%.^$*+?()[{\\|')

  let escaped_for_ack = substitute(escaped_for_ack, "'", '\\x27', "g")
  let escaped_for_ack = substitute(escaped_for_ack, '"', '\\x22', "g")

  " execute Ack command
  exe ":Ack! '" . escaped_for_ack . "'"

  if g:ackhighlight
    " rewrite @/ that was set by Ack
    let @/ = substitute(@/, '\\x2\([27]\)', '\\%x2\1', "g")
  endif

  " recover @@ register
  let @@ = reg_save
endfunction

vmap <Leader>/ :<C-U>call <SID>AckSelected()<CR>
