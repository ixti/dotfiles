#!/bin/sh

test -f ~/.env && source ~/.env

setxkbmap -layout "us,ru" -option "grp:shifts_toggle,ctrl:nocaps,terminate:ctrl_alt_bksp"

# reset xrandr settings and sets random wallpaper
(~/.screenlayout/reset.sh && ~/.local/bin/random-wallpaper.sh safe) &

# start dropbox
dropbox start &

# start notification daemon
dunst &

xmonad
