return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "SuperBo/fugit2.nvim",

    {
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make", -- compile for Linux/macOS

      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions   = require("telescope.actions")

    telescope.load_extension("fzf")

    telescope.setup({
      defaults = {
        prompt_prefix    = "   ",
        selection_caret  = " ",
        path_display     = { "smart" },
        sorting_strategy = "ascending",

        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },

          width = 0.9,
          height = 0.85,
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },

      pickers = {
        find_files = { hidden = true },
      },

      extensions = {
        fzf = {
          fuzzy                   = true,         -- Fuzzy matching
          override_generic_sorter = true,         -- Replace the generic sorter
          override_file_sorter    = true,         -- Replace the file sorter
          case_mode               = "smart_case", -- Ignore case unless capital letters
        },
      },
    })

    -- Recent files scoped down to git workdir or current working directory
    local function telescope_recent_files()
      require("telescope.builtin").oldfiles({
        cwd = require("utils.fs").git_root_or_fallback()
      })
    end

    -- Keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live Grep" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Find Buffers" })
    keymap.set("n", "<leader>fm", telescope_recent_files,          { desc = "Recently opened files" })
  end,
}
