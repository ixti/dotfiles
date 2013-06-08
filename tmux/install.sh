#!/bin/sh


rm -rf backup


test -e ~/.tmux       && mkdir -p backup && cp -r ~/.tmux       backup
test -e ~/.tmux.conf  && mkdir -p backup && cp -r ~/.tmux.conf  backup


ln -s $PWD/.tmux      ~/.tmux
ln -s $PWD/.tmux.conf ~/.tmux.conf
