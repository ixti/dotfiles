#!/usr/bin/env bash

source "${0%/*}/../share/functions.sh"

git clone https://github.com/zplug/zplug "${HOME}/.zplug"
install .zshrc
