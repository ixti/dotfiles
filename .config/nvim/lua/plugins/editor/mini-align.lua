return {
  "nvim-mini/mini.align",

  version = false,

  config = function(_, opts)
    require("mini.align").setup(opts)
  end,
}
