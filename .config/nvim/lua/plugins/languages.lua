-- Just a couple of endless nights trying to get treesitter to at least some
-- working state, and I'm back to battle-tested plain-vim plugins. At some point
-- I even thought the problems I have are because of NeoVim itself, but no, it
-- was treesitter all along... Will revisit treesitter, once it will be stable.
return {
  -- Ruby
  { "vim-ruby/vim-ruby" },
  { "tpope/vim-rails" },

  -- Go
  { "fatih/vim-go" },

  -- JavaScript / TypeScript / React
  { "pangloss/vim-javascript" },
  { "leafgarland/typescript-vim" },
  { "maxmellon/vim-jsx-pretty" },

  -- Lua
  { "tbastos/vim-lua" },

  -- Config files (package names are pretty descriptive)
  { "cespare/vim-toml" },
  { "stephpy/vim-yaml" },
  { "elzr/vim-json" },

  -- endwise.vim: Wisely add
  { "tpope/vim-endwise" },
}
