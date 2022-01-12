if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"
else
  export PURE_GIT_PULL=0
  export PURE_PROMPT_SYMBOL="$"
  export PURE_PROMPT_VICMD_SYMBOL=">"

  fpath+="${ZDOTDIR:-$HOME}/.zsh/lib/pure"
  source "${ZDOTDIR:-$HOME}/.zsh/lib/pure/pure.plugin.zsh"
fi
