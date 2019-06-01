export PURE_GIT_PULL=0
export PURE_PROMPT_SYMBOL=">>="
export PURE_PROMPT_VICMD_SYMBOL="<$>"

fpath=( "${ZDOTDIR:-$HOME}/.zsh/functions" $fpath )

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
