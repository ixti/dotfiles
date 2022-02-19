# Major performance hogger - +110ms
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

source "${ZDOTDIR:-$HOME}/.zsh/lib/colors/colors.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

source "${ZDOTDIR:-$HOME}/.zsh/prompt.zsh"

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
if [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
  # Lazy SdkMan
  function sdk() {
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${HOME}/.sdkman/bin/sdkman-init.sh"
    sdk "$@"
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

[[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
