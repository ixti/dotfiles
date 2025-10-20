# Location Aliases
################################################################################

hash -d guru-overlay=/var/db/repos/guru
hash -d gentoo-overlay=/var/db/repos/gentoo

# Command Aliases
################################################################################

# Make standard ls colourful automagically, but don't replace it with LSD
alias ls='ls --color=auto'

# The next gen ls command
# https://github.com/lsd-rs/lsd
if (( ${+commands[lsd]} )); then
  alias ll='lsd --all -l'
  alias la='lsd --almost-all'
else
  alias ll='ls --color=auto --all --long'
  alias la='ls --color=auto --almost-all'
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
alias ror="bundle exec rails"

# Other tools
alias om="overmind"
alias av="aws-vault"
alias ave="aws-vault exec"
