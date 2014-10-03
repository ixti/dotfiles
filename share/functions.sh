function install()
{
  local src=$(realpath "${0%/*}/$1")
  local dst="${HOME}/${1}"

  ln --force --no-dereference --symbolic "${src}" "${dst}"
}
