return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    -- Set capabilities to all LSP servers
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities()
    })

    -- Ruby LSP: `gem install ruby-lsp`
    vim.lsp.enable("ruby_lsp")

    -- Typescript LSP: `npm i -g typescript-language-server`
    vim.lsp.enable("ts_ls")

    -- Deno LSP: `mise use deno` or `sudo emerge dev-lang/deno-bin` (::GENTOO)
    vim.lsp.enable("denols")

    -- Go LSP: `go install golang.org/x/tools/gopls@latest`
    vim.lsp.enable("gopls")

    -- Lua LSP: `sudo emerge dev-util/lua-language-server` (::GURU)
    vim.lsp.enable("lua_ls")

    -- *** Key Mappings ********************************************************

    vim.api.nvim_create_autocmd("LspAttach", {
      group    = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local keymap_default_opts = {
          noremap = true,
          silent  = true,
          buffer  = ev.buf
        }

        local function keymap(mode, lhs, rhs, opts)
          local extended_opts = vim.tbl_extend("force", keymap_default_opts, opts or {})

          vim.keymap.set(mode, lhs, rhs, extended_opts)
        end

        keymap({ "n", "x" }, "grf", function()
          vim.lsp.buf.format()
        end, { desc = "Format Code (LSP)" })

        keymap({ "n" }, "grd", function()
          Snacks.picker.lsp_definitions()
        end, { desc = "Goto Definition (LSP + snacks.nvim)" })
      end,
    })
  end,
}
