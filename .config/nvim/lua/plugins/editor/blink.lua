return {
  "saghen/blink.cmp",

  version = "1.*",

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap  = { preset = "default" },
    fuzzy   = { implementation = "prefer_rust" },

    sources = {
      default   = { "lsp", "path", "buffer", "omni" },
      providers = {
        lsp = {
          name      = "LSP",
          module    = "blink.cmp.sources.lsp",
          fallbacks = {}, -- always show buffer, even when LSP is available
        },
      },
    },

    -- UI Customization

    completion = {
      menu          = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
    },

    signature = {
      enabled = false,
      window  = { border = "rounded" },
    },
  },

  opts_extend = { "sources.default" },
}
