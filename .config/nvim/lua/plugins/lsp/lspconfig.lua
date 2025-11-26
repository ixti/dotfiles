return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    -- Set capabilities to all LSP servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities()
    })

    -- *** Enable Language Servers *********************************************

    local maybe_enable = require("utils.lsp").maybe_enable

    maybe_enable("ruby_lsp", {
      check   = { "ruby-lsp", "--version" },
      warn    = "ruby-lsp not found.\n\z- try: `gem install ruby-lsp`",
      on_fail = function()
        maybe_enable("rubocop", {
          check = { "bundle", "show", "rubocop" },
          warn  = "Rubocop not found.\n\z- try: `bundle add rubocop`",
        })
      end
    })

    maybe_enable("ts_ls", {
      check = { "typescript-language-server", "--version" },
      warn  = "Typescript language server not found.\n\z
               - try: `npm i -g typescript-language-server`",
    })

    maybe_enable("denols", {
      check = { "deno", "lsp", "--help" },
      warn  = "Deno not found.\n\z
               - try: `mise use deno`\n\z
               - or: `sudo emerge dev-lang/deno-bin`",
    })

    maybe_enable("gopls", {
      check = { "gopls", "version" },
      warn  = "Go language server not found.\n\z
               - try: `go install golang.org/x/tools/gopls@latest`",
    })

    -- *** Key Mappings ********************************************************

    vim.api.nvim_create_autocmd("LspAttach", {
      group    = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local keymap = vim.keymap.set

        local function opts(overrides)
          return vim.tbl_extend(
            "force",
            { noremap = true, silent = true, buffer = event.buf },
            overrides or {}
          )
        end

        keymap("n", "K",          vim.lsp.buf.hover,       opts({ desc = "Preview (LSP)" }))
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts({ desc = "Code Actions (LSP)" }))

        keymap({ "n", "v" }, "<leader>cf",
          vim.lsp.buf.format,
          opts({ desc = "Format Code (LSP)" })
        )

        keymap("n", "<C-]>",
          function() Snacks.picker.lsp_definitions() end,
          opts({ desc = "Goto Definition (snacks.nvim)" })
        )

        keymap("n", "<leader>rn",
          function() require("live-rename").rename() end,
          opts({ desc = "LSP Rename (live-rename.nvim)" })
        )
      end,
    })
  end,
}
