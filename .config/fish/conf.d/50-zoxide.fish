# A smarter cd command.
# NOTE: Must be last thing in the config, if used with `--cmd cd`
# https://github.com/ajeetdsouza/zoxide
status is-interactive; and type -q zoxide; or exit

zoxide init fish | source
