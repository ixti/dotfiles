return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    strategies = {
      chat = {
        -- Install with:
        -- bun i -g @zed-industries/claude-code-acp @anthropic-ai/claude-code
        adapter = "claude_code",
      }
    }
  },
}
