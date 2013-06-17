#!/bin/sh


rm -rf backup


backup () { (test -e $1 && mkdir -p $2 && cp -r $1 $2) }


backup ~/.vim               ./backup
backup ~/.vimrc             ./backup
backup ~/.config/powerline  ./backup/.config


rm -rf ~/.vim && ln -s $PWD/.vim ~/.vim
rm -rf ~/.vimrc && ln -s $PWD/.vimrc ~/.vimrc
rm -rf ~/.config/powerline && ln -s $PWD/.config/powerline ~/.config/powerline


test -e backup && mv backup backup-$(date +%s)
