source ~/.zplug/init.zsh

PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL=">>="

zplug "Tarrasch/zsh-autoenv"

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

# zplug "mafredri/zsh-async"
# zplug "sindresorhus/pure"

zstyle ":prezto:module:editor" key-bindings "vi"
zplug "modules/editor", from:prezto

zstyle ":prezto:module:utility:ls" color "yes"
zplug "modules/utility", from:prezto

zstyle ":prezto:module:ruby:chruby" auto-switch "yes"
zplug "modules/ruby", from:prezto

zstyle ":prezto:module:prompt" theme "pure"
zplug "modules/prompt", from:prezto

zplug "modules/directory", from:prezto
zplug "modules/history", from:prezto
zplug "modules/gpg", from:prezto
zplug "modules/ssh", from:prezto
zplug "modules/rails", from:prezto

# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

setopt nocorrectall
setopt interactivecomments

alias tmux="tmux -2"
alias service="sudo service"
alias shutdown="sudo shutdown"
alias pm-suspend="sudo pm-suspend"

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
