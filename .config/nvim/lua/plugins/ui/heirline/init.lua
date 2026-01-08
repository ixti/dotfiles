return {
  "rebelot/heirline.nvim",

  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-mini/mini.icons",
    "stevearc/aerial.nvim",
  },

  event = "UiEnter",

  config = function()
    local heirline   = require("heirline")
    local conditions = require("heirline.conditions")
    local utils      = require("heirline.utils")

    local function setup_colors()
      return {
        delimiter_fg            = utils.get_highlight("Conceal").fg,
        inactive_fg             = utils.get_highlight("Comment").fg,

        macro_recording_fg      = utils.get_highlight("DiagnosticWarn").fg,
        search_stats_fg         = utils.get_highlight("HeirlineModeSpecial").bg,
        selection_stats_fg      = utils.get_highlight("HeirlineModeVisual").bg,

        diag_errors_fg          = utils.get_highlight("DiagnosticError").fg,
        diag_warnings_fg        = utils.get_highlight("DiagnosticWarn").fg,
        diag_hints_fg           = utils.get_highlight("DiagnosticHint").fg,
        diag_infos_fg           = utils.get_highlight("DiagnosticInfo").fg,

        git_branch_fg           = utils.get_highlight("Special").fg,

        git_hunks_added_fg      = utils.get_highlight("GitSignsAdd").fg,
        git_hunks_removed_fg    = utils.get_highlight("GitSignsDelete").fg,
        git_hunks_changed_fg    = utils.get_highlight("GitSignsChange").fg,

        read_only_file_mark_fg  = utils.get_highlight("Error").fg,
        unsaved_changes_mark_fg = utils.get_highlight("Changed").fg,

        vimode_fg               = utils.get_highlight("Normal").bg,
        vimode_normal_bg        = utils.get_highlight("HeirlineModeNormal").bg,
        vimode_insert_bg        = utils.get_highlight("HeirlineModeInsert").bg,
        vimode_visual_bg        = utils.get_highlight("HeirlineModeVisual").bg,
        vimode_selection_bg     = utils.get_highlight("HeirlineModeSelection").bg,
        vimode_replace_bg       = utils.get_highlight("HeirlineModeReplace").bg,
        vimode_special_bg       = utils.get_highlight("HeirlineModeSpecial").bg,
      }
    end

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

        colors = setup_colors,
      },

      winbar     = require("plugins.ui.heirline.winbar"),
      statusline = require("plugins.ui.heirline.statusline"),
    })

    local buffer_diagnostics = require("plugins.ui.heirline.shared.buffer_diagnostics")
    local group              = vim.api.nvim_create_augroup("Heirline", { clear = true })

    vim.api.nvim_create_autocmd("ColorScheme", {
      desc     = "Reset Heirline colors",
      group    = group,
      callback = function() utils.on_colorscheme(setup_colors) end,
    })

    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      group    = group,
      desc     = "Reset Heirline diagnostic stats cache",
      callback = function(args)
        buffer_diagnostics.reset(args.buf)
        vim.cmd.redrawstatus()
      end,
    })

    vim.api.nvim_create_autocmd("BufDelete", {
      group    = group,
      desc     = "Cleanup Heirline diagnostic stats cache for deleted buffer",
      callback = function(args)
        buffer_diagnostics.clear(args.buf)
      end,
    })

    -- Disable tabline completely
    vim.opt.showtabline = 0
  end,
}
