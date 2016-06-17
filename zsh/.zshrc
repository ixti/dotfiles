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
  zgen prezto gpg
  zgen prezto ssh
  zgen prezto ruby
  zgen prezto rails
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search

  zgen save
fi

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"
alias service="sudo service"
alias shutdown="sudo shutdown"
alias pm-suspend="sudo pm-suspend"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
