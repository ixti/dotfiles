DISABLE_AUTO_UPDATE="true"

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen oh-my-zsh

  zgen oh-my-zsh plugins/aws
  zgen oh-my-zsh plugins/chruby
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/gem
  zgen oh-my-zsh plugins/knife
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/rake
  zgen oh-my-zsh plugins/redis-cli
  zgen oh-my-zsh plugins/taskwarrior
  zgen oh-my-zsh plugins/vagrant
  zgen oh-my-zsh plugins/zeus
  zgen oh-my-zsh plugins/pass

  zgen oh-my-zsh themes/kphoen

  zgen load Tarrasch/zsh-autoenv

  zgen save
fi

setopt nocorrectall

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias tmux="tmux -2"
alias xterm="setsid xterm"
alias urxvt="setsid urxvt"
alias feh="feh --geometry 1280x800"
