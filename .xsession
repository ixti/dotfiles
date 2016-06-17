#!/bin/sh

if [ -f "${HOME}/.env" ]; then
  # shellcheck source=.xsession
  . "${HOME}/.env"
fi

# reset xrandr settings and sets random wallpaper
(~/.screenlayout/reset.sh && ~/.local/bin/random-wallpaper.sh safe) &

# start dropbox
(pkill dropbox && sleep 1 && dropbox) &

# start notification daemon
dunst &

# start ALSA tray mixer
volti &

xmonad
