status is-interactive; and type -q fzf; and type -q zoxide; or exit

function zz --description 'samrt cd with zoxide and fzf'
  set -l dir (zoxide query -l | fzf)
  test -d "$dir"; and cd "$dir"
end
