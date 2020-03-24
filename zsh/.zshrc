source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.zsh"

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

# Lazy PyEnv
pyenv() {
  # Remove ourselves
  unset -f pyenv

  # Python version manager (https://github.com/pyenv/pyenv)
  if [[ -d "${HOME}/.pyenv/bin" ]]; then
    path=("${HOME}/.pyenv/bin" $path)
    export PATH

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi

  pyenv "$@"
}

# Java SDK/JDK manager (https://sdkman.io)
if [[ -e "/home/ixti/.sdkman" ]]; then
  export SDKMAN_DIR="/home/ixti/.sdkman"

  [[ -s "/home/ixti/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ixti/.sdkman/bin/sdkman-init.sh"
fi
