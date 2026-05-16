# vim: ft=zsh

if [[ ! -f "${ZDOTDIR}/.zshrc.zwc" || "${ZDOTDIR}/.zshrc" -nt "${ZDOTDIR}/.zshrc.zwc" ]]; then
  # Recompile in background
  (zcompile -- "${ZDOTDIR}/.zshrc.zwc" "${ZDOTDIR}/.zshrc") &!
fi

# Uncomment to profile
# zmodload zsh/zprof

# ZSH Options -- https://zsh.sourceforge.io/Doc/Release/Options.html
################################################################################

# Core interaction options
setopt autocd              # Change directories just by typing their names.
setopt autopushd           # Keep a directory stack when using cd.
setopt pushdignoredups     # Avoid duplicates in directory stack.
setopt nobeep              # Disable annoying terminal beep.
setopt interactivecomments # Allow comments in interactive mode.
setopt correct             # Try to correct the spelling of commands.
setopt nocorrectall        # But don't correct arguments.
setopt promptsubst         # Allow variable expansion in prompts.
setopt pathscript          # Allow Zsh to locate and execute scripts in $PATH
                           # when invoked without a full or relative path.

# Auto-completion
setopt completeinword      # Complete from both ends of a word.
setopt alwaystoend         # Move cursor to the end of a completed word.
setopt pathdirs            # Perform path search even on command names with slashes.
setopt automenu            # Show completion menu on a successive tab press.
setopt autolist            # Automatically list choices on ambiguous completion.
setopt autoparamslash      # If completed parameter is a directory, add a trailing slash.
setopt nomenucomplete      # Do not autoselect the first completion entry.
setopt noflowcontrol       # Disable start/stop characters in shell editor.

# Filename and globbing behavior
setopt extendedglob        # Enable advanced globbing (e.g., ^, ~, and ** wildcards).
setopt nocaseglob          # Make filename completion case-insensitive.
setopt nomatch             # Print an error when glob patterns don't match.
setopt noglobdots          # Hide dotfiles unless you explicitly include them.

# Command history
setopt extendedhistory     # Record timestamps in history.
setopt histignoredups      # Don’t record duplicate commands.
setopt histignorespace     # Ignore commands prefixed with a space.
setopt histreduceblanks    # Remove redundant empty lines from history.
setopt incappendhistory    # Append to history file incrementally (no loss on crash).
setopt sharehistory        # Share history across multiple Zsh sessions.
setopt histverify          # Confirm before executing recalled history commands.
setopt histfcntllock       # Prevents occasional corruption when multiple shells are open.

# Safety and strictness
setopt noclobber           # Prevent overwriting files with > redirection.
setopt localoptions        # Make option changes local to functions.
setopt localtraps          # Make traps local to functions.

# Process management
setopt notify              # Report job status changes immediately.
setopt nohup               # Prevent background jobs from hanging up on logout.
setopt nobgnice            # Don't run all background jobs at a lower priority.
setopt nocheckjobs         # Don't report on jobs when shell exit.
                           # NOTE: set unhup and unset hup serve different
                           #       purposes.
unsetopt hup               # Don't kill jobs on shell exit.

# Debugging
# setopt sourcetrace         # Print the name of each file as it is sourced.

# Setup ZSH History
################################################################################

typeset -rgx HISTFILE="${ZSTATEDIR}/history"
typeset -rgx HISTSIZE=10000
typeset -rgx SAVEHIST=10000

# Preconfigure ZLE
################################################################################

# Make URL pasting safer by automatically escaping it
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Plugins
################################################################################

# ENV for `zsh-users/zsh-autosuggestions` plugin
typeset -rgxi ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -rgxa ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ENV for `mattmc3/ez-compinit`
typeset -rgx  ZSH_COMPDUMP="${ZCACHEDIR}/zcompdump"

zstyle ':antidote:*'          'zcompile'   'yes'
zstyle ':plugin:ez-compinit'  'compstyle'  'zshzoo'
zstyle ':plugin:ez-compinit'  'use-cache'  'yes'

autoload -Uz antidote

zsh_plugins="${ZDOTDIR}/.zsh_plugins"

if [[ ! -f "${zsh_plugins}.txt" || ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  [[ -f "${zsh_plugins}.txt" ]] || touch "${zsh_plugins}.txt"

  antidote bundle < "${zsh_plugins}.txt" >| "${zsh_plugins}.zsh"
fi

source "${zsh_plugins}.zsh"

# Integrations
################################################################################

# The front-end to your dev env
# https://mise.jdx.dev/
if (( ${+commands[mise]} )) && (( ! ${+functions[mise]} )); then
  # Mise activation itself is not problematic, but its env-hook is as heavy as
  # the rest of this configuration, LOL
  zsh-defer -c 'source <(command mise activate zsh)'
fi

# The minimal, blazing-fast, and infinitely customizable prompt.
# https://starship.rs/
if (( ${+commands[starship]} )); then
  source <(command starship init zsh)
fi

# A command-line fuzzy finder
# https://github.com/junegunn/fzf
if (( ${+commands[fzf]} )); then
  source <(command fzf --zsh)
fi

# A smarter cd command
# NOTE: Must be last thing in the config, if used with `--cmd cd`
# https://github.com/ajeetdsouza/zoxide
if (( ${+commands[zoxide]} )); then
  source <(command zoxide init zsh)
fi

# GPG/SSH Agents
if [[ -o interactive ]] && (( $+commands[gpgconf] )); then
  () {
    local gpg_ssh_socket
    gpg_ssh_socket="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"

    # Proceed only if GPG successfully reports a valid socket path
    if [[ -n "${gpg_ssh_socket}" ]]; then
      # Bind the SSH auth mechanism globally to GPG Agent
      export SSH_AUTH_SOCK="${gpg_ssh_socket}"
      
      # Zsh natively populates the $TTY variable for interactive shells. 
      # Fall back to the tty command only if $TTY is missing.
      export GPG_TTY="${TTY:-$(tty 2>/dev/null)}"

      # Ensure gpg-agent is awake. If systemd socket activation is handling 
      # it, gpg-connect-agent will automatically ping it to life.
      if ! gpg-connect-agent /bye >/dev/null 2>&1; then
        gpgconf --launch gpg-agent >/dev/null 2>&1
      fi

      # Validates that the TTY is a valid character device.
      if [[ -n "$GPG_TTY" && -c "$GPG_TTY" ]]; then
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
      fi
    fi
  }
fi

# Aliases
################################################################################

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

# VI-mode bindkeys
################################################################################

# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#lazy-keybindings
function zvm_after_lazy_keybindings() {
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

# Completions navigation
################################################################################

zmodload zsh/complist
zstyle ':completion:*:*:*:*:*' menu select

# Add Shift+Tab reverse completion
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
else
  bindkey '^[[Z' reverse-menu-complete
fi

# Register autoloadable function
################################################################################

() {
  local funs=(
    "${ZDOTDIR}/local/functions"/*(N:t)
    "${ZDOTDIR}/functions"/*(N:t)
  )

  (( $#funs )) && autoload -Uz "${funs[@]}"
}

# Local Overrides
################################################################################

local zshrc_local="${ZDOTDIR}/local/zshrc"
[[ -r "$zshrc_local" ]] && source "$zshrc_local"
unset zshrc_local

################################################################################

(( ${+builtins[zprof]} )) && zprof || true
