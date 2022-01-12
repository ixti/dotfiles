export AUTOENV_IN_FILE=".autoenv.in.zsh"
export AUTOENV_OUT_FILE=".autoenv.out.zsh"

# if I have sudo powers, I want sudo <tab> to work properly
path=( $path /sbin /usr/sbin /usr/local/sbin )

# Rust cargo binaries
if [[ -d "${HOME}/.cargo/bin" ]]; then
  path=("${HOME}/.cargo/bin" $path)
fi

if [[ -d "${HOME}/.pyenv/bin" ]]; then
  path=("${HOME}/.pyenv/bin" $path)
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
