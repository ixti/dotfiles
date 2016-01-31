#!/bin/sh

test -f ~/.env && source ~/.env

# reset xrandr settings and sets random wallpaper
(~/.screenlayout/reset.sh && ~/.local/bin/random-wallpaper.sh safe) &

# start dropbox
dropbox start &

# start notification daemon
dunst &

xmonad
