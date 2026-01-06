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
    local highlight = oklch.highlight

    oklch.setup(opts)

    -- https://github.com/eero-lehtinen/oklch-color-picker.nvim/pull/70
    -- Snacks.toggle.new({
    --   id   = "oklch-highlight",
    --   name = "OKLCH Highlight",
    --   get  = highlight.is_enabled,
    --   set  = function(state)
    --     if state then highlight.disable() else highlight.enable() end
    --   end,
    -- }):map("<leader>to")

    vim.api.nvim_create_user_command("OklchToggle", function()
      highlight.toggle()
    end, {})

    vim.api.nvim_create_user_command("OklchEnable", function()
      highlight.enable()
    end, {})

    vim.api.nvim_create_user_command("OklchDisable", function()
      highlight.disable()
    end, {})

    vim.api.nvim_create_user_command("OklchEdit", function()
      oklch.pick_under_cursor()
    end, {})

    vim.api.nvim_create_user_command("OklchInsert", function()
      oklch.open_picker()
    end, {})
  end,
}
