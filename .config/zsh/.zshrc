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

# Additional ENV (meaningful in the interactive shell only)
################################################################################

# A themeable LS_COLORS generator with a rich filetype datebase.
# https://github.com/sharkdp/vivid/
if (( ${+commands[vivid]} )); then
  typeset -gx LS_COLORS="$(vivid generate tokyonight-moon)"
else
  typeset -gx LS_COLORS="${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}"
fi

# ENV for `zsh-users/zsh-autosuggestions` plugin
typeset -rgxi ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -rgxa ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ENV for `mattmc3/ez-compinit`
typeset -rgx  ZSH_COMPDUMP="${ZCACHEDIR}/zcompdump"

# Preconfigure ZLE
################################################################################

# Make URL pasting safer by automatically escaping it
source "${ZDOTDIR}/zshrc/safer-copy-pasta.zsh"

# Plugins
################################################################################

zstyle ':antidote:*'            'zcompile'   'yes'
zstyle ':plugin:ez-compinit'    'compstyle'  'prez'
zstyle ':plugin:ez-compinit'    'use-cache'  'yes'

source "${ZDOTDIR}/.antidote/antidote.zsh"
antidote load

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

# A smarter cd command.
# NOTE: Must be last thing in the config, if used with `--cmd cd`
# https://github.com/ajeetdsouza/zoxide
if (( ${+commands[zoxide]} )); then
  source <(command zoxide init zsh)
fi

# Functions
################################################################################

autoload -Uz gh-access-token
autoload -Uz zz

# Location and Command Aliases
################################################################################

source "${ZDOTDIR}/zshrc/aliases.zsh"
source "${ZDOTDIR}/zshrc/binds.zsh"
source "${ZDOTDIR}/zshrc/ssh-and-gnupg.zsh"

# Local Overrides
################################################################################

local zshrc_local="${ZDOTDIR}/local/zshrc"
[[ -r "$zshrc_local" ]] && source "$zshrc_local"
unset zshrc_local

################################################################################

(( ${+builtins[zprof]} )) && zprof || true
