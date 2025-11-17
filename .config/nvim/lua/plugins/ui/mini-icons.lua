return {
  "nvim-mini/mini.icons",

  lazy     = false,
  priority = 1000,
  version  = false,

  config = function()
    require("mini.icons").setup()
  end,
}
