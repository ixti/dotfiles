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
  # Lazy SdlkMan
  function sdk() {
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${HOME}/.sdkman/bin/sdkman-init.sh"
    sdk "$@"
  }
fi

if (( ${+commands[fzf]} && ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

if (( ${+commands[vivid]} )); then
  # https://github.com/sharkdp/vivid/pull/78
  # https://github.com/sharkdp/vivid/pull/79
  export LS_COLORS="$(vivid --database ~/.config/vivid/filetypes.yml generate ~/.config/vivid/gruvbox-dark-hard.yml)"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi
