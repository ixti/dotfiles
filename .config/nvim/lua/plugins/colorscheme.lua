-- STABLE
return {
  "ellisonleao/gruvbox.nvim",

  priority = 9000,

  config = function(opts)
    require("gruvbox").setup({
      contrast         = "hard",
      terminal_colors  = true,
      undercurl        = true,
      bold             = true,
      strikethrough    = true,
      transparent_mode = false,
      italic           = { comments = true, strings = false },
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
