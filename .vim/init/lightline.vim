function! lightline#gitbranch() abort
  try
    return gina#component#repo#branch()
  catch
    return ''
  endtry
endfunction

let g:lightline =
  \ {
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': { 'lineinfo': ' %3l:%-2v' },
  \   'component_function': { 'gitbranch': 'lightline#safe_branch' },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' }
  \ }
