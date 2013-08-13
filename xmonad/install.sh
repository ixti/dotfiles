#!/bin/sh


rm -rf backup


test -e ~/.xmonad && mkdir -p backup  && cp -r ~/.xmonad backup


rm -rf ~/.xmonad && ln -s $PWD/.xmonad ~/.xmonad


test -e backup && mv backup backup-$(date +%s)
