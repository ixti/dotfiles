set -gx EDITOR "vim"
set -gx VISUAL "vim"
set -gx PAGER  "less"

set -q LANG; or set -gx LANG "en_US.UTF-8"

set -gx MANPATH "$HOME/.local/share/man" $MANPATH

set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME;   or set -gx XDG_DATA_HOME "$HOME/.local/share"

if type -q xdg-open
  set -gx BROWSER "xdg-open"
end

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
set -gx LESS "-F -g -i -M -R -S -w -X -z-4"

if type -q lesspipe
  set -gx LESSOPEN "| /usr/bin/env lesspipe %s 2>&-"
end
