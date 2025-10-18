# Major performance hogger - +110ms
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Zprezto gets in the way of compinit in a very weird way... o_O
#   rm -rf .config/zprezto .zcompdump
# https://superuser.com/a/1092328
# autoload -Uz compinit && compinit
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"

alias tig="LEFTHOOK=0 tig"

# https://github.com/drduh/YubiKey-Guide?tab=readme-ov-file#using-multiple-yubikeys
alias smartcard-reset='gpg-connect-agent killagent /bye && gpg-connect-agent "scd serialno" "learn --force" /bye && gpg --card-status'

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND="fd --type file --hidden --no-ignore --follow --exclude .git"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zsh/local.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zsh/local.zsh"
fi

source "${ZDOTDIR:-$HOME}/.zsh/github-helpers.zsh"

source "$HOME/.config/zsh/.zshrc"
