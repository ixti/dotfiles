function github-private-registry-update-access-token() {
  xdg-open https://github.com/settings/tokens

  echo "Please create new token and paste it here..."

  secret-tool store --label="Github Private Registries Access Token" github token

  github-private-registry-setup
}

function github-private-registry-setup() {
  local api_token

  api_token="$(secret-tool lookup github token)"

  export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="x-api-token:${api_token}"
}
