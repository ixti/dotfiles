#!/usr/bin/env bash

for name in ctags tmux vim xmonad; do
  (echo "${*}" | grep -q "\-\-no\-${name}") && continue
  "./${name}/install.sh"
done
