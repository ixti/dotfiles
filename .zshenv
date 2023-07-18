# https://github.com/zpm-zsh/autoenv
export AUTOENV_IN_FILE=".autoenv.in.zsh"
export AUTOENV_OUT_FILE=".autoenv.out.zsh"

# Spring gives me headaches most of the time
# https://github.com/rails/spring
export DISABLE_SPRING=true

# https://github.com/sharkdp/bat/
export BAT_THEME="gruvbox-dark"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"

# https://www.cryfs.org
export CRYFS_NO_UPDATE_CHECK=true
export CRYFS_LOCAL_STATE_DIR="${XDG_DATA_HOME}/cryfs"

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN ]]; then
  for zprofile in "/etc/zsh/zprofile" "${ZDOTDIR:-$HOME}/.zprofile"; do
    [[ -s "${zprofile}"  ]] && source "${zprofile}"
  done

  unset zprofile
fi
