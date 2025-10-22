return {
  {
    "nvim-treesitter/nvim-treesitter",

    lazy   = false,
    branch = "main",
    build  = ":TSUpdate",

    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },

    opts = function(_, opts)
      opts.ensure_installed = {
        "bash",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "ruby",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      }

      opts.highlight = { enable = true }
      opts.indent    = { enable = true, disable = { "yaml", "ruby" } }
      opts.endwise   = { enable = true }
    end,
  }
}
