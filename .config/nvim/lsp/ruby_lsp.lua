-- NOTE: Don't use Mason to install the `ruby-lsp`.
return {
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },

    enabledFeatures = {
      diagnostics = false, -- Disable RuboCop diagnostics
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
