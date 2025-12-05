return {
  cmd     = { "bundle", "exec", "rubocop", "--lsp" },
  cmd_env = {
    RUBY_YJIT_ENABLE = "1",
  },
}
