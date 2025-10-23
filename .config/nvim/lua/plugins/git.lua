return {
  {
    "lewis6991/gitsigns.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "SuperBo/fugit2.nvim",

    build = false,

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.icons",
    },

    cmd = { "Fugit2", "Fugit2Blame", "Fugit2Diff", "Fugit2Graph" },

    opts = {
      width = 100,
      height = "70%",
      external_diffview = true, -- use Diffview.nvim for better diffs
      show_patch = false,
      blame_priority = 1,
    },

    keys = {
      { '<leader>gg', mode = 'n', '<cmd>Fugit2<cr>' },
      { '<leader>gb', mode = 'n', '<cmd>Fugit2Blame toggle<cr>' },
    },
  }
}
