#!/bin/sh

test -f "/etc/X11/xinit/Xresources" && xrdb -merge "/etc/X11/xinit/Xresources"
test -f "/etc/X11/xinit/Xmodmap" && xmodmap "/etc/X11/xinit/Xmodmap"

test -f "$HOME/.Xresources" && xrdb -merge "$HOME/.Xresources"
test -f "$HOME/.Xmodmap" && xmodmap "$HOME/.Xmodmap"

setxkbmap -layout "us,ru" -option "grp:shifts_toggle,ctrl:nocaps,terminate:ctrl_alt_bksp"

{
  ~/.screenlayout/reset.sh
  sleep 1
  # set random wallpaper with nitrogen
  ~/.local/bin/random-wallpaper.sh safe
} &


# start notification daemon
dunst &


# start compoziting manager
xcompmgr &


# start dropbox
{
  sleep 5
  dropbox start
} &


# start power manager
# xfce4-power-manager &


# start blueman applet
blueman-applet &


# start network manager applet
nm-applet -sm-disable &

# In case if we are not using login manager (gdm/kdm/lidhtdm/etc) we might
# need call `exec` with `ck-launch-session`: `exec ck-launch-session i3`
# See: https://wiki.archlinux.org/index.php/Awesome#Using_awesome
exec ck-launch-session xmonad
