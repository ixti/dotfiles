local wezterm = require 'wezterm'
local config = {}


if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Gruvbox dark, hard (base16)'

config.font = wezterm.font 'Victor Mono'

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "NONE"

return config
