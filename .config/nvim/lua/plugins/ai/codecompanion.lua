return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },

  opts = {
    strategies = {
      chat = {
        -- Install with:
        -- bun i -g @zed-industries/claude-code-acp @anthropic-ai/claude-code
        adapter = "claude_code",
      }
    },
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            defaults = {
              model = vim.env.ANTHROPIC_MODEL or "opus"
            },
          })
        end,
      },
    },
    display = {
      chat = {
        show_header_separator = true,
        show_settings         = true,
        show_token_count      = true,
        show_tools_processing = true,
      }
    },
  },

  config = function(_, opts)
    require("codecompanion").setup(opts)

    local progress = require("fidget.progress")
    local handles  = {}
    local group    = vim.api.nvim_create_augroup("CodeCompanionFidget", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      pattern  = "CodeCompanionRequestStarted",
      group    = group,
      callback = function(args)
        if handles[args.data.id] then
          pcall(function() handles[args.data.id]:cancel() end)
        end

        local adapter     = args.data.adapter
        local interaction = args.data.interaction
        local title       = " Requesting assistance"
        local llm_name    = adapter.formatted_name or adapter.name or "Unknown Adapter"

        if interaction and interaction ~= "" then
          title = title .. " (" .. interaction .. ")"
        end

        if adapter.model and adapter.model ~= "" then
          llm_name = llm_name .. " (" .. adapter.model .. ")"
        end

        local handle = progress.handle.create({
          title      = title,
          lsp_client = { name = llm_name },
        })

        handles[args.data.id] = handle
      end,
    })

    local status = {
      success   = "󰗡 Completed",
      error     = " Error",
    }

    vim.api.nvim_create_autocmd("User", {
      pattern  = "CodeCompanionRequestFinished",
      group    = group,
      callback = function(args)
        local handle = handles[args.data.id]

        if not handle then
          return
        end

        handles[args.data.id] = nil

        local message = status[args.data.status]

        if not message then
          message = "Unknown Status (" .. (args.data.status or "???") .. ")"
        end

        handle:report({ message = message })
        handle:finish()
      end,
    })
  end,
}
