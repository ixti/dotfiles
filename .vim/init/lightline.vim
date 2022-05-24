let g:lightline =
  \ {
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
  \   'component': { 'lineinfo': ' %3l:%-2v' },
  \   'component_function': { 'gitbranch': 'FugitiveHead' },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' }
  \ }
