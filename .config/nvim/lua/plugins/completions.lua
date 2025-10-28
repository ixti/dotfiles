return {
  "hrsh7th/nvim-cmp",

  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
  },

  config = function ()
    local cmp     = require("cmp")
    local lspkind = require("lspkind")

    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<CR>"]      = cmp.mapping.confirm(),

        -- Tab navigation between completions and snippets
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- elseif luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          -- elseif luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode          = "symbol_text", -- shows text + icon
          maxwidth      = 50,
          ellipsis_char = "...",

          menu = {
            nvim_lsp = "[LSP]",
            buffer   = "[Buffer]",
            path     = "[Path]",
            luasnip  = "[Snip]",
            nvim_lua = "[Lua]",
          },
        }),
      },

      sources = cmp.config.sources({
        { name = "buffer" },
        { name = "nvim_lsp" },
        -- { name = "luasnip",  keyword_length = 2 },
        { name = "path" }
      }),
    })
  end,
}
