vim9script

set backupdir=$XDG_STATE_HOME/vim/backup
call mkdir(&backupdir, 'p', 0o700)

set directory=$XDG_STATE_HOME/vim/swap
call mkdir(&directory, 'p', 0o700)

set viewdir=$XDG_STATE_HOME/vim/view
call mkdir(&viewdir, 'p', 0o700)

set undodir=$XDG_STATE_HOME/vim/undo
call mkdir(&undodir, 'p', 0o700)

set viminfofile=$XDG_STATE_HOME/vim/viminfo

# # Persistent Undo
set undofile
