return {
  "smjonas/inc-rename.nvim",

  config = function(_, opts)
    require("inc_rename").setup(opts)

    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
  end,
}
