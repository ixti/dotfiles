# Major performance hogger - +110ms
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Zprezto gets in the way of compinit in a very weird way... o_O
#   rm -rf .config/zprezto .zcompdump
# https://superuser.com/a/1092328
# autoload -Uz compinit && compinit
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source "${ZDOTDIR:-$HOME}/.zsh/lib/colors/colors.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/autoenv/autoenv.plugin.zsh"
source "${ZDOTDIR:-$HOME}/.zsh/lib/zsh-history-substring-search/zsh-history-substring-search.zsh"

if [[ -n "$key_info" ]]; then
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
  bindkey -M viins "$key_info[Up]" history-substring-search-up
  bindkey -M viins "$key_info[Down]" history-substring-search-down
fi

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

path=( "${HOME}/bin" $path )

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

if (( ${+commands[vivid]} )); then
  LS_COLORS="$(vivid generate gruvbox-dark-hard)"
  export LS_COLORS
fi

# https://github.com/Schniz/fnm
if (( ${+commands[fnm]} )); then
  source <(fnm env --shell zsh)
fi

# https://starship.rs/
if (( ${+commands[starship]} )); then
  # See: https://github.com/starship/starship/issues/2637
  source <(starship init zsh --print-full-init)
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi

# Note that zsh-syntax-highlighting must be the last plugin sourced.
# See: <https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager>
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
