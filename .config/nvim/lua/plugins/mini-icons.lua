return {
  "nvim-mini/mini.icons",

  lazy     = false,
  priority = 1000,

  config = function()
    -- Mock nvim-web-devicons globally so everything uses mini.icons
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()

      return package.loaded["nvim-web-devicons"]
    end
  end,
}
