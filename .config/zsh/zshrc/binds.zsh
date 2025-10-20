# Key Bindings
################################################################################

# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#lazy-keybindings
function zvm_after_lazy_keybindings() {
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}
