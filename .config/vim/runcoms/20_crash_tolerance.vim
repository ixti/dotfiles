vim9script

&backupdir   = $XDG_STATE_HOME .. "/vim/backup"
&directory   = $XDG_STATE_HOME .. "/vim/swap"
&viewdir     = $XDG_STATE_HOME .. "/vim/view"
&undodir     = $XDG_STATE_HOME .. "/vim/undo"
&viminfofile = $XDG_STATE_HOME .. "/vim/viminfo"

mkdir(&backupdir, "p", 0o700)
mkdir(&directory, "p", 0o700)
mkdir(&viewdir,   "p", 0o700)
mkdir(&undodir,   "p", 0o700)

# # Persistent Undo
&undofile = true
