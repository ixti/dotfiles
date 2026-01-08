# https://gitlab.gnome.org/GNOME/libsecret/
if (( ${+commands[secret-tool]} )); then
  # Update using `gh-access-token update package-registry`.
  # Make sure that token has only `packages:read` access.
  local __github_token="$(gh-access-token show package-registry)"

  if [[ -n "${__github_token}" ]]; then
    typeset -gx BUNDLE_RUBYGEMS__PKG__GITHUB__COM="x-api-token:${__github_token}"
  fi

  unset __github_token
fi
