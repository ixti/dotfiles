return {
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
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
  },
}
