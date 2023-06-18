function aye_or_nay() {
  local question="$1"
  local response

  typeset -l response

  if [[ ! -o interactive ]]; then
    return 1
  fi

  while true; do
    read "response?${question}? (y/n)"

    if [[ -z "${response}" ]]; then
      return 0
    fi

    case "${response}"; in
      y|ye|yes)
        return 0
        ;;

      n|no)
        return 1
        ;;

      *)
        echo "Wat?"
        ;;
    esac
  done
}
