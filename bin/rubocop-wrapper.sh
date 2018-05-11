#!/bin/sh

function _hasBundler() {
  local path=${PWD:A}
  local file

  while true; do
    file="${path}/Gemfile.lock"

    if [[ -e "$file" ]]; then
      return 0;
    fi

    if [[ "/" = $path ]]; then
      return 1;
    else
      path=$(dirname "$path")
    fi
  done
}

if _hasBundler; then
  exec bundler exec rubocop $*
else
  exec rubocop $*
fi
