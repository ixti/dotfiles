if &term =~ "xterm" || &term =~ "screen"
  if has("terminfo")
    set t_Co=256
    set t_Sf=<Esc>[3%p1%dm
    set t_Sb=<Esc>[4%p1%dm
  else
    set t_Co=8
    set t_Sf=<Esc>[3%dm
    set t_Sb=<Esc>[4%dm
  endif
endif

if has("termguicolors")
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  set termguicolors
endif
