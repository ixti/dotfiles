-- NOTE: Don't use Mason to install the `rubocop`
return {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
}
