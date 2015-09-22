#!/usr/bin/env bash

source "${0%/*}/../share/functions.sh"

git clone https://github.com/tarjoilija/zgen.git ${HOME}/.zgen
install .zshrc
