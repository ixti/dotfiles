# A themeable LS_COLORS generator with a rich filetype datebase.
# https://github.com/sharkdp/vivid/
type -q vivid; or exit

set -gx LS_COLORS "$(vivid generate gruvbox-dark-hard)"
