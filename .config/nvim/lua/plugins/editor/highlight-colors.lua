return {
  "brenoprata10/nvim-highlight-colors",

  opts = {
    render                = "foreground", -- "foreground" | "background" | "virtual"
    virtual_symbol        = "▣",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    enable_tailwind       = true,

    -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
    exclude_filetypes = {},
    exclude_buftypes = {},

    -- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr)  end'
    exclude_buffer = function(bufnr)
      return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000
    end,
  },

  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
  end,
}
