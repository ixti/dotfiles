# https://github.com/zpm-zsh/autoenv
export AUTOENV_IN_FILE=".autoenv.in.zsh"
export AUTOENV_OUT_FILE=".autoenv.out.zsh"

# Spring gives me headaches most of the time
# https://github.com/rails/spring
export DISABLE_SPRING=true

# https://github.com/sharkdp/bat/
export BAT_THEME="gruvbox-dark"

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
