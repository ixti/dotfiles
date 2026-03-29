# Start or re-use gpg-agent
if (( ${+commands[gpgconf]} )); then
  # Export the SSH socket from GPG agent
  typeset -gx SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

  # Export the TTY (needed for GUI pinentry and SSH prompts)
  typeset -gx GPG_TTY="$(tty 2>/dev/null)"

  # Initialize gpg in background
  {
    # Start GPG agent if not already running
    if ! gpg-connect-agent /bye >/dev/null 2>&1; then
      gpgconf --launch gpg-agent &>/dev/null
    fi

    # Update the agent's idea of this terminal
    gpg-connect-agent updatestartuptty /bye &>/dev/null
  } &!
fi
