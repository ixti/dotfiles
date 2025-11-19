return {
  "saghen/blink.cmp",

  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap  = { preset = "default" },
    fuzzy   = { implementation = "prefer_rust" },

    snippets = {
      preset = "luasnip",
    },

    -- UI Customization

    completion = {
      menu          = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
      ghost_text    = { enabled = true },
    },

    signature = { window = { border = "rounded" } },
  },
}
