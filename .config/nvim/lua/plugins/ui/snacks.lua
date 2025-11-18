return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy     = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-mini/mini.icons",
    "folke/which-key.nvim",
  },

  opts = {
    indent       = { enabled = true },
    notifier     = { enabled = true, timeout = 1000 },
    statuscolumn = { enabled = true },

    explorer = {
      replace_netrw = true,
      trash         = true,
    },

    styles = {
      zen = {
        width = 0.8,
      },
    },
  },

  keys = {
    { "<leader>e",  function() Snacks.explorer() end,                   desc = "File Explorer (snacks.nvim)" },

    { "<leader>ff", function() Snacks.picker.files() end,               desc = "Find Files (snacks.nvim)" },
    { "<leader>fb", function() Snacks.picker.buffers() end,             desc = "Find buffers (snacks.nvim)" },
    { "<leader>fg", function() Snacks.picker.grep() end,                desc = "Grep (snacks.nvim)" },
    { "<leader>fm", function() Snacks.picker.smart() end,               desc = "Smart Find Files (snacks.nvim)" },

    { "<leader>fc", function() Snacks.picker.command_history() end,     desc = "Command History (snacks.nvim)" },
    { "<leader>fC", function() Snacks.picker.commands() end,            desc = "Commands (snacks.nvim)" },

    { "<leader>fk", function() Snacks.picker.keymaps() end,             desc = "Keymaps (snacks.nvim)" },

    { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end,  desc = "Buffer Diagnostics (snacks.nvim)" },
    { "<leader>fD", function() Snacks.picker.diagnostics() end,         desc = "Diagnostics (snacks.nvim)" },

    { "<leader>..", function() Snacks.scratch() end,                    desc = "Toggle Scratch Buffer (snacks.nvim)" },
    { "<leader>./", function() Snacks.scratch.select() end,             desc = "Select Scratch Buffer (snacks.nvim)" },

    -- TODO: Figure out if I'm ever gonan use these

    { "<leader>bd", function() Snacks.bufdelete() end,                  desc = "Delete Buffer (snacks.nvim)" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,         desc = "Rename File (snacks.nvim)" },
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    vim.api.nvim_create_user_command(
      "Notifications",
      function() Snacks.notifier.show_history() end,
      {}
    )

    Snacks.toggle.zen():map("<leader>zz")
    Snacks.toggle.dim():map("<leader>zd")
  end,
}
