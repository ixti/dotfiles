function github-access-token() {
  secret-tool lookup github token
}

function github-private-registry-update-access-token() {
  xdg-open https://github.com/settings/tokens

  echo "Please create new token and paste it here..."

  secret-tool store --label="Github Private Registries Access Token" github token

  github-private-registry-setup
}

function github-private-registry-setup() {
  export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="x-api-token:$(github-access-token)"
}
