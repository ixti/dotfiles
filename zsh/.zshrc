source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen load Tarrasch/zsh-autoenv

  # prezto options
  zgen prezto editor key-bindings "vi"
  zgen prezto prompt theme "pure"

  # prezto and it's modules
  zgen prezto
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto history
  zgen prezto directory
  zgen prezto spectrum
  zgen prezto utility
  zgen prezto completion
  zgen prezto git
  zgen prezto helper
  zgen prezto history-substring-search
  zgen prezto ruby

  zgen save
fi

setopt nocorrectall

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias tmux="tmux -2"
alias ls="ls --color=auto"
