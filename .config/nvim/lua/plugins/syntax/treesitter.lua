--- Only use Tree-sitter indentation for languages where it's known to work well.
--- Other filetypes will use their default indentexpr (often better for Ruby, HTML, etc.)
---@type string[]
local USE_TS_INDENT_FOR = {
  "go",
  "javascript",
  "json",
  "jsx",
  "lua",
  "python",
  "typescript",
  "tsx",
}

return {
  "nvim-treesitter/nvim-treesitter",

  lazy   = false,
  branch = "main",

  build  = ":TSUpdate",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  config = function()
    require("nvim-treesitter").install({
      "bash",
      "dart",
      "diff",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "hcl",
      "html",
      "http",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "json5",
      "jsx",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "mermaid",
      "nginx",
      "python",
      "rbs",
      "regex",
      "ruby",
      "rust",
      "sql",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "zsh",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group    = vim.api.nvim_create_augroup("MyTS", { clear = true }),
      callback = function(event)
        if pcall(vim.treesitter.start, event.buf) then
          local bo = vim.bo[event.buf]

          if vim.list_contains(USE_TS_INDENT_FOR, bo.filetype) then
            bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end
        end
      end,
    })
  end,
}
