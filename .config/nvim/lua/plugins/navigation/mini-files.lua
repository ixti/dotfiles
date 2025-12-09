return {
  "nvim-mini/mini.files",

  version = false,

  dependencies = {
    "nvim-mini/mini.icons",
  },

  opts = {
    options = {
      permanent_delete = false,
    },
  },

  keys = {
    {
      "<leader>e",
      function()
        local MiniFiles = require("mini.files")

        if not MiniFiles.close() then
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = "File Crawler (mini.files)",
    },
  },

  config = function(_, opts)
    local MiniFiles = require("mini.files")

    MiniFiles.setup(opts)

    local augroup = vim.api.nvim_create_augroup("MiniFilesCustomizations", { clear = true })
    local keymap  = vim.keymap.set

    local map_split = function(direction)
      local cur_entry = MiniFiles.get_fs_entry()

      if cur_entry == nil or cur_entry.fs_type ~= "file" then
        return
      end

      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. " split")

        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      MiniFiles.go_in()
    end

    vim.api.nvim_create_autocmd("User", {
      group   = augroup,
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buffer = args.data.buf_id

        keymap("n", "<C-s>", function()
          map_split("belowright horizontal")
        end, { buffer = buffer, desc = "Split below" })

        keymap("n", "<C-v>", function()
          map_split("belowright vertical")
        end, { buffer = buffer, desc = "Split right" })

        keymap("n", "<CR>", function()
          MiniFiles.go_in({ close_on_file = true })
        end, { buffer = buffer, desc = "Go in entry plus (alias)" })
      end,
    })
  end,
}
