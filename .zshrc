source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

source "${ZDOTDIR:-$HOME}/.zsh/lib/colors/colors.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

source "${ZDOTDIR:-$HOME}/.zsh/prompt.zsh"


# autoload -Uz promptinit
# promptinit
# prompt pure

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

alias venv="python3 -m venv"

if (( ${+functions[chruby]} )); then
  if [[ "${HOME}" != "${PWD}" ]] && [[ -f .ruby-version ]]; then
    chruby "$(cat .ruby-version)"
  else
    chruby ruby
  fi
fi

if (( ${+commands[pyenv]} )); then
  # Lazy PyEnv
  function pyenv() {
    # Remove ourselves
    unset -f pyenv

    # Python version manager (https://github.com/pyenv/pyenv)
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    pyenv "$@"
  }
fi

# Java SDK/JDK manager (https://sdkman.io)
if [[ -e "/home/ixti/.sdkman" ]]; then
  # Lazy SdlkMan
  function sdk() {
    export SDKMAN_DIR="/home/ixti/.sdkman"

    if [[ -s "/home/ixti/.sdkman/bin/sdkman-init.sh" ]]; then
      source "/home/ixti/.sdkman/bin/sdkman-init.sh"
    fi

    sdk "$@"
  }
fi

if (( ${+commands[fzf]} && ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

# case "$TERM" in
#   *-kitty)
#     autoload -Uz compinit
#     compinit
#     kitty + complete setup zsh | source /dev/stdin
#     alias kitty-diff="kitty +kitten diff"
#     alias kitty-icat="kitty +kitten icat"
#     ;;
# esac

FLUTTER_DIR="/home/ixti/.local/opt/flutter"
if [[ -d "${FLUTTER_DIR}/bin" ]]; then
  path=("${FLUTTER_DIR}/bin" "${FLUTTER_DIR}/.pub-cache/bin" $path)
fi

if (( ${+commands[vivid]} )); then
  # https://github.com/sharkdp/vivid/pull/78
  # https://github.com/sharkdp/vivid/pull/79
  export LS_COLORS="$(vivid --database ~/.config/vivid/filetypes.yml generate ~/.config/vivid/gruvbox-dark-hard.yml)"
fi

export PINENTRY_USER_DATA="terminal"
export GPG_TTY="$(tty)"
if (( ${+commands[keychain]} )); then
  eval "$(keychain --quiet --quick --noask --eval --agents gpg,ssh)"
fi

# Install `br` helper
if (( ${+commands[broot]} )); then
  eval "$(broot --print-shell-function zsh)"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi
