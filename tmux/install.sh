#!/bin/sh


rm -rf backup


test -e ~/.tmux       && mkdir -p backup && cp -r ~/.tmux       backup
test -e ~/.tmux.conf  && mkdir -p backup && cp -r ~/.tmux.conf  backup


rm -rf ~/.tmux      && ln -s $PWD/.tmux      ~/.tmux
rm -rf ~/.tmux.conf && ln -s $PWD/.tmux.conf ~/.tmux.conf


test -e backup && mv backup backup-$(date +%s)
