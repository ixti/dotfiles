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

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"

alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"
alias om="overmind"
alias gbv="git branch --verbose --verbose"
alias gfp="git fetch --prune"
alias gri="git rebase --interactive"
alias tig="LEFTHOOK=0 tig"

alias av="aws-vault"
alias ave="aws-vault exec"

# https://github.com/drduh/YubiKey-Guide?tab=readme-ov-file#using-multiple-yubikeys
alias smartcard-reset='gpg-connect-agent killagent /bye && gpg-connect-agent "scd serialno" "learn --force" /bye && gpg --card-status'

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

path=( "${HOME}/bin" "${HOME}/.local/bin" "${HOME}/go/bin" "${HOME}/.cargo/bin" $path )
export MANPATH=$HOME/.local/share/man:$MANPATH

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

source "${ZDOTDIR:-$HOME}/.zsh/ls_colors.zsh"

# https://starship.rs/
if (( ${+commands[starship]} )); then
  # See: https://github.com/starship/starship/issues/2637
  source <(starship init zsh --print-full-init)
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi

source "${ZDOTDIR:-$HOME}/.zsh/github-helpers.zsh"

# Note that zsh-syntax-highlighting must be the last plugin sourced.
# See: <https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager>
source "${ZDOTDIR:-$HOME}/.zsh/lib/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
