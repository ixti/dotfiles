export PURE_GIT_PULL=0
export PURE_PROMPT_SYMBOL="$"
export PURE_PROMPT_VICMD_SYMBOL=">"

fpath=( "${ZDOTDIR:-$HOME}/.zsh/functions" $fpath )

# if I have sudo powers, I want sudo <tab> to work properly
path=( $path /sbin /usr/sbin /usr/local/sbin )

# Rust cargo binaries
if [[ -d "${HOME}/.cargo/bin" ]]; then
  path=("${HOME}/.cargo/bin" $path)
fi

if (( ${+commands[vivid]} )); then
  # XXX: if this generates error, ensure to install filetypes database and themes:
  #
  #     # tune this var a bit ;))
  #     vivid_cargo=~/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/
  #
  #     rm -rf ~/.config/vivid
  #     install -Dm644 -t ~/.config/vivid "${vivid_cargo}"/config/filetypes.yml
  #     install -Dm644 -t ~/.config/vivid/themes "${vivid_cargo}"/themes/*.yml
  export LS_COLORS=$(vivid generate jellybeans)
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
