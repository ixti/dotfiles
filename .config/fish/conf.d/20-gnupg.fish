gpgconf --launch gpg-agent

set -e SSH_AUTH_SOCK
set -Ux SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -Ux GPG_TTY (tty)
