vim9script

augroup MkpathIfNotExistOnSave
  def MaybeCreatePath(path: string, force: bool): void
    if empty(path) || isdirectory(path)
      return
    endif

    if force || 1 == confirm("'" .. path .. "' does not exist. Create?", "&Yes\n&No", 2)
      mkdir(iconv(path, &encoding, &termencoding), "p")
      return
    endif

    return
  enddef

  autocmd!
  autocmd BufWritePre * MaybeCreatePath(expand("<afile>:p:h"), 1 == v:cmdbang)
augroup END
