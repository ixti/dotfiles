set -g fish_greeting

set PATH $HOME/bin $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin $PATH

set -gx EDITOR vim
set -gx MANPATH "$HOME/.local/share/man" $MANPATH

if type -q vivid
  set -gx LS_COLORS "$(vivid generate gruvbox-dark-hard)"
end

if status is-interactive
  if type -q starship
    function starship_transient_rprompt_func
      starship module time
    end

    starship init fish | source
    enable_transience
  end

  fish_vi_key_bindings
end
