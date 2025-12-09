return {
  "eero-lehtinen/oklch-color-picker.nvim",

  event   = "VeryLazy",
  version = "*",

  opts = {
    highlight = {
      enabled       = false,
      style         = "foreground+virtual_left",
      register_cmds = false,
    },
  },

  config = function(_, opts)
    local oklch = require("oklch-color-picker")

    oklch.setup(opts)

    vim.api.nvim_create_user_command("OklchToggle", function()
      oklch.highlight.toggle()
    end, {})

    vim.api.nvim_create_user_command("OklchEnable", function()
      oklch.highlight.enable()
    end, {})

    vim.api.nvim_create_user_command("OklchDisable", function()
      oklch.highlight.disable()
    end, {})

    vim.api.nvim_create_user_command("OklchEdit", function()
      oklch.pick_under_cursor()
    end, {})

    vim.api.nvim_create_user_command("OklchInsert", function()
      oklch.open_picker()
    end, {})
  end,
}
