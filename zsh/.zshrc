source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/zsh-autoenv/autoenv.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/idiots-are-taking-over.zsh"

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi
