#!/bin/sh

if [ -f "${HOME}/.env" ]; then
  # shellcheck source=.xsession
  . "${HOME}/.env"
fi

# reset xrandr settings and sets random wallpaper
(~/.screenlayout/reset.sh && ~/.local/bin/random-wallpaper.sh safe) &

# start dropbox
(pkill dropbox && sleep 1 && dropbox) &

# start X autolocker
command -v xautolock >/dev/null 2>&1 && xautolock -detectsleep &

# start notification daemon
command -v dunst >/dev/null 2>&1 && dunst &

xmonad
