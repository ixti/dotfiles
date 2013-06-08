#!/bin/sh


rm -rf backup


test -e ~/.vim    && mkdir -p backup && cp -r ~/.vim    backup
test -e ~/.vimrc  && mkdir -p backup && cp -r ~/.vimrc  backup


ln -s $PWD/.vim   ~/.vim
ln -s $PWD/.vimrc ~/.vimrc
