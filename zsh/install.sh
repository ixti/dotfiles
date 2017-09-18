#!/usr/bin/env bash

source "${0%/*}/../share/functions.sh"

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

install .zsh
install .zlogin
install .zpreztorc
install .zprofile
install .zshenv
install .zshrc
