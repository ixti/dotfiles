return {
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },

    indexing = {
      excludedGems = {
        "rubocop",
        "rubocop-ast",
        "rubocop-factory_bot",
        "rubocop-performance",
        "rubocop-rails",
        "rubocop-rspec",
        "rubocop-rspec_rails",
        "sorbet-runtime",
      },

      excludedPatterns = {
        "tmp/**",
        "log/**",
        "spec/**",
        "**/node_modules/**",
        "**/vendor/**",
      },
    },
  },
}

