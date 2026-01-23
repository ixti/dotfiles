return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "franco-ruggeri/codecompanion-spinner.nvim",
  },

  opts = {
    strategies = {
      chat = {
        -- Install with:
        -- bun i -g @zed-industries/claude-code-acp @anthropic-ai/claude-code
        adapter = "claude_code",
      }
    },
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            defaults = {
              model = vim.env.ANTHROPIC_MODEL or "opus"
            },
          })
        end,
      },
    },
    extensions = {
      spinner = {},
    },
  },

  config = function(_, opts)
    require("codecompanion").setup(opts)
  end,
}
