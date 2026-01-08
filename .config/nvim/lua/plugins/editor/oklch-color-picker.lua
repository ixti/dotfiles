return {
  "eero-lehtinen/oklch-color-picker.nvim",

  event   = "VeryLazy",
  version = "*",

  dependencies = {
    "folke/snacks.nvim",
  },

  opts = {
    highlight = {
      enabled       = true,
      style         = "foreground+virtual_left",
      register_cmds = false,
    },
  },

  config = function(_, opts)
    local oklch     = require("oklch-color-picker")
    local highlight = require("oklch-color-picker.highlight")

    oklch.setup(opts)

    Snacks.toggle.new({
      id   = "oklch_highlighting",
      name = " OKLCH highlighting",
      get  = highlight.is_enabled,
      set  = function(state)
        highlight[state and "enable" or "disable"]()
      end,
    }):map("<leader>to")

    vim.api.nvim_create_user_command("OklchToggle", highlight.toggle, {
      desc = "Toggle OKLCH highlighting (oklch-color-picker.nvim)",
    })

    vim.api.nvim_create_user_command("OklchEnable", highlight.enable, {
      desc = "Enable OKLCH highlighting (oklch-color-picker.nvim)",
    })

    vim.api.nvim_create_user_command("OklchDisable", highlight.disable, {
      desc = "Disable OKLCH highlighting (oklch-color-picker.nvim)",
    })

    vim.api.nvim_create_user_command("OklchEdit", oklch.pick_under_cursor, {
      desc = "Edit color under cursor (oklch-color-picker.nvim)",
    })

    vim.api.nvim_create_user_command("OklchInsert", oklch.open_picker, {
      desc = "Insert color (oklch-color-picker.nvim)",
    })
  end,
}
