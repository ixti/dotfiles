return {
  "nvim-mini/mini.surround",

  version = false,
  event   = { "BufReadPost", "BufNewFile" },

  config = function()
    require("mini.surround").setup()
  end
}
