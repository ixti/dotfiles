setopt nocorrectall
setopt interactivecomments

# Setup colors
if (( ${+commands[vivid]} )); then
  LS_COLORS="$(vivid generate gruvbox-dark-hard)"
  export LS_COLORS
fi

# Plugins - TODO: Switch to antidote?
################################################################################

source "${XDG_CONFIG_HOME}/zsh/plugins/colors/colors.plugin.zsh"
source "${XDG_CONFIG_HOME}/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Aliases
################################################################################

# Ruby
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bo="bundle open"
alias ror="bundle exec rails"

# Git
alias gbv="git branch --verbose --verbose"
alias gfp="git fetch --prune"
alias gri="git rebase --interactive"

# Other tools
alias om="overmind"
alias av="aws-vault"
alias ave="aws-vault exec"

################################################################################

# The minimal, blazing-fast, and infinitely customizable prompt.
# https://starship.rs/
if (( ${+commands[starship]} )); then
  # See: https://github.com/starship/starship/issues/2637
  source <(starship init zsh --print-full-init)
fi

# A command-line fuzzy finder
# https://github.com/junegunn/fzf
if (( ${+commands[fzf]} )); then
  source <(fzf --zsh)
fi

# A smarter cd command.
# NOTE: Must be last thing in the config, if used with `--cmd cd`
# https://github.com/ajeetdsouza/zoxide
if (( ${+commands[zoxide]} )); then
  source <(zoxide init zsh)

  function zz() {
    local dir="$(zoxide query -l | fzf)"
    [[ -d "$dir" ]] && cd "$dir"
  }
fi

# Note that zsh-syntax-highlighting must be the last plugin sourced.
# See: <https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#with-a-plugin-manager>
source "${XDG_CONFIG_HOME}/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
