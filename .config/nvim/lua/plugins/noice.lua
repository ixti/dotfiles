return {
  "folke/noice.nvim",

  event = "VeryLazy",

  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "smjonas/inc-rename.nvim",
    "hrsh7th/nvim-cmp",
  },

  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"]                = true,
        ["cmp.entry.get_documentation"]                  = true,
      },
    },

    presets = {
      bottom_search         = true, -- classic bottom search bar
      command_palette       = true, -- blend cmdline and popupmenu
      long_message_to_split = true, -- move long messages to a split
      inc_rename            = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border        = true, -- add borders around hover docs
    },

    routes = {
      {
        filter = { event = "msg_show", find = "Trouble" },
        view   = "mini",
      },
      {
        filter = { event = "msg_show", find = "search_count" },
        opts   = { skip = true },
      },
      {
        filter = { event = "msg_show", kind = "" },
        opts   = { skip = true },
      },
    },

    views = {
      split = {
        size        = "40%",
        win_options = { colorcolumn = "" },
      },
    },
  },
}
