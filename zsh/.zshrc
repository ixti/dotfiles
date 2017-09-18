source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/zsh-autoenv/autoenv.zsh"

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"
alias service="sudo service"
alias shutdown="sudo shutdown"
alias pm-suspend="sudo pm-suspend"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi
