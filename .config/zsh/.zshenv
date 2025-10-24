# vim: ft=zsh

# XDG - https://specifications.freedesktop.org/basedir-spec/latest/#variables
################################################################################

local default_xdg_cache_home="${HOME}/.cache"
local default_xdg_config_home="${HOME}/.config"
local default_xdg_data_home="${HOME}/.local/share"
local default_xdg_state_home="${HOME}/.local/state"

typeset -gx XDG_CACHE_HOME="${XDG_CACHE_HOME:-${default_xdg_cache_home}}"
typeset -gx XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${default_xdg_config_home}}"
typeset -gx XDG_DATA_HOME="${XDG_DATA_HOME:-${default_xdg_data_home}}"
typeset -gx XDG_STATE_HOME="${XDG_STATE_HOME:-${default_xdg_state_home}}"

# Ensure XDG paths are not relative (as per the spec's "absolute path" rule)
# If those are incorrect, warn and set to default one

if [[ "${XDG_CACHE_HOME}" != /* ]]; then
  print -u2 "XDG_CACHE_HOME must be absolute, got: ${XDG_CACHE_HOME}"
  print -u2 "Falling back to default: ${default_xdg_cache_home}"
  XDG_CACHE_HOME="${default_xdg_cache_home}"
fi

if [[ "${XDG_CONFIG_HOME}" != /* ]]; then
  print -u2 "XDG_CONFIG_HOME must be absolute, got: ${XDG_CONFIG_HOME}"
  print -u2 "Falling back to default: ${default_xdg_config_home}"
  XDG_CONFIG_HOME="${default_xdg_config_home}"
fi

if [[ "${XDG_DATA_HOME}" != /* ]]; then
  print -u2 "XDG_DATA_HOME must be absolute, got: ${XDG_DATA_HOME}"
  print -u2 "Falling back to default: ${default_xdg_data_home}"
  XDG_DATA_HOME="${default_xdg_data_home}"
fi

if [[ "${XDG_STATE_HOME}" != /* ]]; then
  print -u2 "XDG_STATE_HOME must be absolute, got: ${XDG_STATE_HOME}"
  print -u2 "Falling back to default: ${default_xdg_state_home}"
  XDG_STATE_HOME="${default_xdg_state_home}"
fi

# Cleanup temporary variables

unset default_xdg_{cache,config,data,state}_home

# Ensure XDG paths exist, create if necessary

local xdg_dir
for xdg_dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"; do
  if [[ ! -d "$xdg_dir" ]]; then
    print -u2 "Creating missing XDG directory: $xdg_dir"
    mkdir -p -m 0700 "$xdg_dir"
  fi
done
unset xdg_dir

# Disallow further modifications of critical XDG paths.
# But allow modifications of `$XDG_CACHE_HOME`

typeset -r XDG_{CONFIG,DATA,STATE}_HOME

# Keep ZSH config under `${XDG_CONFIG_HOME}/zsh` by default
################################################################################

typeset -rgx ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
typeset -rgx ZCACHEDIR="${ZCACHEDIR:-${XDG_CACHE_HOME}/zsh}"
typeset -rgx ZSTATEDIR="${ZSTATEDIR:-${XDG_STATE_HOME}/zsh}"

[[ -d "${ZCACHEDIR}" ]] || mkdir -p -m 0700 "${ZCACHEDIR}"
[[ -d "${ZSTATEDIR}" ]] || mkdir -p -m 0700 "${ZSTATEDIR}"

# Setup ZSH History
################################################################################

typeset -rgx HISTFILE="${ZSTATEDIR}/history"
typeset -rgx HISTSIZE=10000
typeset -rgx SAVEHIST=10000

# Setup PNPM
################################################################################

if [[ -z "${PNPM_HOME:-}" ]]; then
  typeset -gx PNPM_HOME="${XDG_DATA_HOME}/pnpm"

  if [[ ! -d "$PNPM_HOME" ]]; then
    print -u2 "Creating missing PNPM directory: $PNPM_HOME"
    mkdir -p -m 0700 "$PNPM_HOME"
  fi
fi

# Setup $PATH, and ensure it contains UNIQUE values only
################################################################################

typeset -gU path=(
  "${HOME}/.local/bin"
  "${HOME}/bin"
  "${HOME}/go/bin"
  "${HOME}/.cargo/bin"
  "${PNPM_HOME}"
  $path
)

# Setup ZSH Functions lookup paths, and ensure it contains UNIQUE values only
################################################################################

typeset -gU fpath=(
  "${ZDOTDIR}/local/functions"
  "${ZDOTDIR}/functions"
  $fpath
)

# System ENV vars
################################################################################

typeset -gx MANPATH="$HOME/.local/share/man:$MANPATH"

typeset -gx EDITOR="vim"
typeset -gx VISUAL="${VISUAL:-$EDITOR}"
typeset -gx PAGER=${PAGER:-/usr/bin/less}

# App-specific ENV vars
################################################################################

# Less is more, LOL
typeset -gx LESSHISTFILE="${XDG_CACHE_HOME}/lesshst"

# A cat(1) clone with wings.
# https://github.com/sharkdp/bat/
typeset -gx BAT_THEME="gruvbox-dark"

# https://www.cryfs.org
typeset -gx CRYFS_NO_UPDATE_CHECK=true
typeset -gx CRYFS_LOCAL_STATE_DIR="${XDG_DATA_HOME}/cryfs"

# Local overrides
################################################################################

local zshenv_local="${ZDOTDIR}/local/zshenv"
[[ -r "$zshenv_local" ]] && source "$zshenv_local"
unset zshenv_local
