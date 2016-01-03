source "${HOME}/.zgen/zgen.zsh"

# pure prompt settings
PURE_GIT_PULL=0

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen load Tarrasch/zsh-autoenv

  # prezto options
  zgen prezto editor key-bindings "vi"
  zgen prezto utility:ls color "yes"
  zgen prezto ruby:chruby auto-switch "yes"
  zgen prezto syntax-highlighting color "yes"
  zgen prezto history-substring-search color "yes"
  zgen prezto prompt theme "pure"

  # prezto and it's modules
  zgen prezto
  zgen prezto environment
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto utility
  zgen prezto completion
  zgen prezto gpg
  zgen prezto ruby
  zgen prezto rails
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  zgen prezto prompt

  zgen save
fi

setopt nocorrectall

alias tmux="tmux -2"
alias gpg="gpg2"
