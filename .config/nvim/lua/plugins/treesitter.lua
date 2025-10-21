-- Run `:TSInstallSync all` after major updates to ensure new parsers get compiled properly

local languages = {
  "bash",
  "c",
  "css",
  "csv",
  "dart",
  "dockerfile",
  "helm",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "javascript",
  "json",
  "lua",
  "python",
  "ruby",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",

    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag", -- For auto-closing HTML/ERB tags
    },

    event = { "BufReadPost", "BufNewFile" },

    build = function()
      -- Always sync install parsers lazily and safely
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = languages,
        sync_install     = false,
        auto_install     = true,

        highlight = {
          enable                            = true,
          additional_vim_regex_highlighting = false,

          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KiB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },

        indent = {
          enable  = true,
          disable = "yaml",
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection    = "gnn",
            node_incremental  = "grn",
            scope_incremental = "grc",
            node_decremental  = "grm",
          },
        },

        autotag = { enable = true },
        endwise = { enable = true },

        textobjects = {
          select = {
            enable    = true,
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },

          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
          },
        },
      })
    end,
  },
}
