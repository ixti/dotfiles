#!/bin/sh

test -f "/etc/X11/xinit/Xresources" && xrdb -merge "/etc/X11/xinit/Xresources"
test -f "/etc/X11/xinit/Xmodmap" && xmodmap "/etc/X11/xinit/Xmodmap"

test -f "~/.Xresources" && xrdb -merge "~/.Xresources"
test -f "~/.Xmodmap" && xmodmap "~/.Xmodmap"

setxkbmap -layout "us,ru" -option "grp:shifts_toggle,ctrl:nocaps,terminate:ctrl_alt_bksp"

# reset xrandr settings, start compoziting manager and sets random wallpaper
(
  ~/.screenlayout/reset.sh
  xcompmgr &
  ~/.local/bin/random-wallpaper.sh safe
) &

# start notification daemon
dunst &

# start dropbox
dropbox start &

# In case if we are not using login manager (gdm/kdm/lidhtdm/etc) we might
# need call `exec` with `ck-launch-session`: `exec ck-launch-session i3`
# See: https://wiki.archlinux.org/index.php/Awesome#Using_awesome
exec ck-launch-session xmonad
