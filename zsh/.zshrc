source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

autoload -Uz promptinit
promptinit
prompt pure

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"

alias om="overmind"
alias oms="overmind start"

alias t="task"
alias T="timew"

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

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi

if (( ${+functions[chruby]} )); then
  chruby ruby
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
  export SDKMAN_DIR="/home/ixti/.sdkman"

  if [[ -s "/home/ixti/.sdkman/bin/sdkman-init.sh" ]]; then
    source "/home/ixti/.sdkman/bin/sdkman-init.sh"
  fi
fi

if (( ${+commands[vivid]} )); then
  # XXX: if this generates error, ensure to install filetypes database and themes:
  #
  #     # tune this var a bit ;))
  #     vivid_cargo=~/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/
  #
  #     rm -rf ~/.config/vivid
  #     install -Dm644 -t ~/.config/vivid "${vivid_cargo}"/config/filetypes.yml
  #     install -Dm644 -t ~/.config/vivid/themes "${vivid_cargo}"/themes/*.yml
  export LS_COLORS="$(vivid generate jellybeans)"
fi
