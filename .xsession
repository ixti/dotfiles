#!/bin/sh

if [ -f "${HOME}/.env" ]; then
  # shellcheck source=.xsession
  . "${HOME}/.env"
fi

reset_screen_and_wallpaper() {
  ~/.screenlayout/reset.sh
  ~/.local/bin/random-wallpaper.sh safe
}

start_dropbox() {
  pkill dropbox >/dev/null 2>&1
  sleep 1
  command -v dropbox >/dev/null 2>&1 && dropbox
}

start_xautolock() {
  command -v xautolock >/dev/null 2>&1 && xautolock -detectsleep
}

reset_screen_and_wallpaper &
start_xautolock &
start_dropbox &

exec xmonad
