return {
  "nvim-mini/mini.ai",

  version = false,
  event   = { "BufReadPost", "BufNewFile" },

  config = function()
    require("mini.ai").setup()
  end
}
