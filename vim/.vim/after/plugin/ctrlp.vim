map <Leader>t :CtrlP<CR>
map <Leader>b :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRUFiles<CR>
map <Leader>T :CtrlPClearCache<CR><Esc>:CtrlP<CR>

" Set a faster fuzzy matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$\|node_modules\|vendor',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" If ag is available use it as filename list generator instead of 'find'
if executable('ag')
  " set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = {
    \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ },
    \ 'fallback': 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore node_modules
    \ --ignore "**/*.pyc"
    \ -g ""'
    \ }
endif
