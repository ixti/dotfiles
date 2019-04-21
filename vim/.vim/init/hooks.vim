augroup MkpathIfNotExistOnSave
  function s:Confirm(message)
    return input(a:message . ' [y/N] ') =~ '\c^y\%[es]$'
  endfunction

  function s:Mkpath(path, force)
    if empty(a:path) || isdirectory(a:path)
      return 0
    endif

    if a:force || s:Confirm("'" . a:path . "' doesn't exists. Create?")
      call mkdir(iconv(a:path, &encoding, &termencoding), 'p')
      return 1
    endif

    return 0
  endfunction

  autocmd!
  autocmd BufWritePre * call s:Mkpath(expand('<afile>:p:h'), v:cmdbang)
augroup END
