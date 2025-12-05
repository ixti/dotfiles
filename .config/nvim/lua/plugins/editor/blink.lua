return {
  "saghen/blink.cmp",

  version = "1.*",

  dependencies = {
    "L3MON4D3/LuaSnip",
  },

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap   = { preset = "default" },
    snippets = { preset = "luasnip" },

    completion = {
      menu          = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
    },

    fuzzy = {
      implementation = "prefer_rust",
      sorts          = { "exact", "score", "sort_text" },
    },

    signature = {
      enabled = false,
      window  = { border = "rounded" },
    },

    sources = {
      default   = { "lsp", "path", "buffer", "snippets" },
      providers = {
        lsp = {
          name      = "LSP",
          module    = "blink.cmp.sources.lsp",
          fallbacks = {}, -- always show buffer, even when LSP is available
        },
      },
    },
  },

  opts_extend = { "sources.default" },
}
