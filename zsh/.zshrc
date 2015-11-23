source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen prezto

  zgen load Tarrasch/zsh-autoenv

  zgen load mafredri/zsh-async
  zgen load sindresorhus/pure

  zgen save
fi

setopt nocorrectall

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias tmux="tmux -2"
# alias ls="ls --color=auto"
# alias ll="ls -la"
