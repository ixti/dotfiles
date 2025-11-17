return {
  "saghen/blink.cmp",

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap  = { preset = "default" },
    default = { "lsp", "buffer", "path" },
    fuzzy   = { implementation = "prefer_rust" },

    completion = {
      menu          = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
    },

    signature = { window = { border = "rounded" } },
  },

  opts_extend = { "sources.default" },
}
