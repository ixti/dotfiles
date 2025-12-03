return {
  "nvim-mini/mini.ai",

  version = false,
  event   = { "BufReadPost", "BufNewFile" },

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  config = function()
    local ai = require("mini.ai")

    ai.setup({
      n_lines            = 500,
      custom_textobjects = {
        -- 'o' for Block/Object (loops, conditionals, blocks)
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),

        -- 'f' for Function (explicitly mapping to textobjects queries)
        f = ai.gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }),

        -- 'c' for Class
        c = ai.gen_spec.treesitter({
          a = "@class.outer",
          i = "@class.inner",
        }),

        -- 't' for Tag (useful for HTML/JSX)
        t = { "<([%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
      }
    })
  end
}
