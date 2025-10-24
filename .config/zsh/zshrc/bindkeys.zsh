# VI-mode bindkeys
################################################################################

# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#lazy-keybindings
function zvm_after_lazy_keybindings() {
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}

# Completions navigation
################################################################################

zmodload zsh/complist
zstyle ':completion:*:*:*:*:*' menu select

# Add Shift+Tab reverse completion
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
else
  bindkey '^[[Z' reverse-menu-complete
fi
