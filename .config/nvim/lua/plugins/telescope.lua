-- TODO
return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
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

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        path_display = { "smart" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.9,
          height = 0.85,
        },
        sorting_strategy = "ascending",
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
          fuzzy = true,                    -- Fuzzy matching
          override_generic_sorter = true,  -- Replace the generic sorter
          override_file_sorter = true,     -- Replace the file sorter
          case_mode = "smart_case",        -- Ignore case unless capital letters
        },
      },
    })

    -- Enable Telescope FZF extension
    telescope.load_extension("fzf")

    -- Keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live Grep" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Find Buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help Tags" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope oldfiles<CR>",   { desc = "Recently opened files" })
  end,
}
