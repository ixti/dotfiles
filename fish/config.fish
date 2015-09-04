set fish_git_dirty_color red
set fish_git_not_dirty_color green
set fish_color_cwd blue

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s)

  if test -n "$git_status"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  set -l realhome ~

  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  set -l user (printf "%s%s%s" (set_color red) (whoami) (set_color normal))
  set -l host (printf "%s%s%s" (set_color purple) (hostname|cut -d . -f 1) (set_color normal))

  set -l prefix (printf "%s@%s" $user $host)

  set -l pwd (printf "%s%s%s" (set_color $fish_color_cwd) (echo $PWD | sed -e "s|^$realhome\$|~|" -e "s|^$realhome/|~/|") (set_color normal))

  if test -n "$git_dir"
    printf "[%s:%s on %s]\n%s" $prefix $pwd (parse_git_branch) "% "
  else
    printf "[%s:%s]\n%s" $prefix $pwd "% "
  end
end
