# Major performance hogger - +110ms
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

source "${ZDOTDIR:-$HOME}/.zsh/lib/colors/colors.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"
alias om="overmind"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

# Java SDK/JDK manager (https://sdkman.io)
if [[ -r "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
  # Lazy SdkMan
  function sdk() {
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    sdk "$@"
  }
fi

# NodeJS versions manager (https://github.com/nvm-sh/nvm)
if [[ -r "${HOME}/.nvm/nvm.sh" ]]; then
  # Lazy NVM
  function nvm() {
    export NVM_DIR="${HOME}/.nvm"
    source "${NVM_DIR}/nvm.sh"
    nvm "$@"
  }
fi

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

if (( ${+commands[vivid]} )); then
  LS_COLORS="$(vivid generate gruvbox-dark-hard)"
  export LS_COLORS
fi

path=( "${HOME}/bin" $path )

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi

# https://starship.rs/
if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"
fi
