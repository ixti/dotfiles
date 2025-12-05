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

    -- Ruby LSP: `gem install ruby-lsp`
    vim.lsp.enable("ruby_lsp")

    -- Typescript LSP: `npm i -g typescript-language-server`
    vim.lsp.enable("ts_ls")

    -- Deno LSP: `mise use deno` or `sudo emerge dev-lang/deno-bin`
    vim.lsp.enable("denols")

    -- Go LSP: `go install golang.org/x/tools/gopls@latest`
    vim.lsp.enable("gopls")

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
