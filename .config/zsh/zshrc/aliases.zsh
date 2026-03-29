# Ask for confirmation when trying to modify existing files
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

## EZA -- Modern replacement for the file-listing command-line program `ls`.
# https://eza.rocks
if (( ${+commands[eza]} )); then
  alias eza="eza --time-style='+%F %R' --git --icons=auto --group --group-directories-first"
  alias ls="eza"
  alias la="eza --all"
  alias ll="eza --all --long"
else
  alias ls="ls --color=auto"
  alias la="ls --almost-all"
  alias ll="ls --almost-all -l"
fi

# Git
alias gbv="git branch --verbose --verbose"
alias gfp="git fetch --prune"
alias gri="git rebase --interactive"

# Ruby
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"

# Other tools
alias om="overmind"
