#!/bin/sh

# ck-launch-session resets X server configuration, thus all xmodmap, xrdb
# and xkbmap settings are lost. Alternatively it's possible to remove
# ck-launch-session from here and so `.xsessionrc` contents will be moved
# back here and XMonad will be started with `exec xmonad`. But in this
# `pm-suspend` and friends will require `sudo`.

# NOTE: Gentoo uses ConsoleKit2 (not original ConsoleKit which was abandoned).

exec ck-launch-session ~/.xsessionrc
