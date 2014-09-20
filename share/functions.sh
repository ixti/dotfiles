function install()
{
  local src=$(realpath "${0%/*}/$1")
  local dst="${HOME}/${1}"

  rm -rf "${dst}"
  mkdir -p $(dirname "${dst}")
  ln -s "${src}" "${dst}"
}
