if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

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

# On Fedora `vim` does not include `+clipboard` for some reason.
# NOTE: SO suggests `gvim -v`: https://vi.stackexchange.com/a/2065
#   I went with `vimx` way as I don't need this anywhere but Fedora,
#   everythin just works on Funtoo/Gentoo.
if (( ${+commands[vimx]} )); then
  alias vim="vimx"
  export EDITOR="vimx"
fi

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
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
  export LS_COLORS="$(vivid generate jellybeans)"
fi

export GPG_TTY="$(tty)"
if (( ${+commands[keychain]} )); then
  eval `keychain --quiet --noask --eval --agents gpg,ssh`
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi
