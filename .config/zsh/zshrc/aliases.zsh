# Location Aliases
################################################################################

hash -d guru-overlay=/var/db/repos/guru
hash -d gentoo-overlay=/var/db/repos/gentoo

# Command Aliases
################################################################################

# Ask for confirmation when trying to modify existing files
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

## EZA -- Modern replacement for the file-listing command-line program `ls`.
# https://eza.rocks
if (( ${+commands[eza]} )); then
  alias ls="eza --time-style='+%F %R' --icons=auto --group"
else
  alias ls="ls --color=auto"
fi

alias la="ls --almost-all"
alias ll="ls --almost-all -l"

# Git
alias gbv="git branch --verbose --verbose"
alias gfp="git fetch --prune"
alias gri="git rebase --interactive"

# Ruby
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"

# Other tools
alias om="overmind"
alias av="aws-vault"
alias ave="aws-vault exec"
