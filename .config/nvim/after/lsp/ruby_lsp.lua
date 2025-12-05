return {
  cmd_env = {
    RUBY_YJIT_ENABLE = "1",
  },

  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },

    enabledFeatures = {
      diagnostics = false,
      formatting  = false,
    },

    excludedGems = {
      "rubocop",
    },

    excludedPatterns = {
      "tmp/**",
      "log/**",
      "spec/**",
      "**/node_modules/**",
      "**/vendor/**",
    },

    formatter = "none",
    linters   = {},
  },
}
