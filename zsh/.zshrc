# pure prompt settings
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL=">>="

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."

  zgen load Tarrasch/zsh-autoenv

  zgen load mafredri/zsh-async
  zgen load sindresorhus/pure

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search

  # prezto options
  zgen prezto editor key-bindings "vi"
  zgen prezto utility:ls color "yes"
  zgen prezto ruby:chruby auto-switch "yes"
  zgen prezto prompt theme "pure"

  # prezto and it's modules
  zgen prezto
  zgen prezto gpg
  zgen prezto ssh
  zgen prezto ruby
  zgen prezto rails

  zgen load zsh-users/zsh-completions

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
