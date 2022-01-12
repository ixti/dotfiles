if (( ${+commands[starship]} )); then
  # https://starship.rs/
  eval "$(starship init zsh)"
else
  # https://github.com/sindresorhus/pure/
  export PURE_GIT_PULL=0
  export PURE_PROMPT_SYMBOL="$"
  export PURE_PROMPT_VICMD_SYMBOL=">"

  fpath+="${ZDOTDIR:-$HOME}/.zsh/lib/pure"
  source "${ZDOTDIR:-$HOME}/.zsh/lib/pure/pure.plugin.zsh"
fi
