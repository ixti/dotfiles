#!/bin/sh


rm -rf backup


test -e ~/.vim    && mkdir -p backup  && cp -r ~/.vim   backup
test -e ~/.vimrc  && mkdir -p backup  && cp -r ~/.vimrc backup
test -e ~/.ctags  && mkdir -p backup  && cp -r ~/.ctags backup


rm -rf ~/.vim && ln -s $PWD/.vim ~/.vim
rm -rf ~/.vimrc && ln -s $PWD/.vimrc ~/.vimrc
rm -rf ~/.ctags && ln -s $PWD/.ctags ~/.ctags


test -e backup && mv backup backup-$(date +%s)
