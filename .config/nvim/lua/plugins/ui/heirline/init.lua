return {
  "rebelot/heirline.nvim",

  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-mini/mini.icons",
  },

  event = "UiEnter",

  config = function()
    local heirline   = require("heirline")
    local conditions = require("heirline.conditions")

    heirline.setup({
      opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks.
        -- See: `:help nvim_lua_create_autocmd()`
        disable_winbar_cb = function (args)
          return conditions.buffer_matches({
            buftype  = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "fugitive", "Trouble", "dashboard" },
          }, args.buf)
        end,
      },

      winbar     = require("plugins.ui.heirline.winbar"),
      statusline = require("plugins.ui.heirline.statusline"),
    })

    -- Disable tabline completely
    vim.opt.showtabline = 0
  end,
}
