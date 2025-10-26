return {
  "ibhagwan/fzf-lua",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
  },

  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      "telescope",
      "fzf-native",

      winopts = {
        fullscreen = true,
        backdrop   = 100,
      }
    })

    -- Git and recent files picker similar to your Telescope custom function using fugit2.nvim
    local git_root_or_cwd = require("utils.fs").git_root_or_cwd

    local function fzf_recent_files()
      fzf.oldfiles({ cwd = git_root_or_cwd() })
    end

    local keymap = vim.keymap.set

    keymap("n", "<leader>ff", function() fzf.files() end, { desc = "Find files" })
    keymap("n", "<leader>fg", function() fzf.live_grep() end, { desc = "Live Grep" })
    keymap("n", "<leader>fb", function() fzf.buffers() end, { desc = "Find Buffers" })
    keymap("n", "<leader>fm", fzf_recent_files, { desc = "Recently opened files" })
  end,
}
