source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen load Tarrasch/zsh-autoenv

  # prezto options
  zgen prezto editor key-bindings "vi"
  zgen prezto utility:ls color "yes"
  zgen prezto ruby auto-switch "yes"
  zgen prezto syntax-highlighting color "yes"
  zgen prezto history-substring-search color "yes"
  zgen prezto prompt theme "pure"

  # prezto and it's modules
  zgen prezto
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto utility
  zgen prezto completion
  zgen prezto ruby
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  zgen prezto prompt

  zgen save
fi

setopt nocorrectall

# bindkey "^[[1;5C" forward-word
# bindkey "^[[1;5D" backward-word

alias tmux="tmux -2"
