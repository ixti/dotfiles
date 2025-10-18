set -gx EDITOR vim
set -gx MANPATH "$HOME/.local/share/man" $MANPATH

set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME;   or set -gx XDG_DATA_HOME "$HOME/.local/share"
