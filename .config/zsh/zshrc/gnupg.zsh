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
