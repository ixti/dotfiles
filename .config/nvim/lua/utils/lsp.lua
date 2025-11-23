local M = {}

local registered_servers = {}

---@class MaybeEnableOpts
--- If the given command exists with non-zero status, LSP won't be enabled
--- and a warning (see below) will be shown instead.
---@field check table
--- Warning message to show when check command fails.
---@field warn string
--- List of filetypes to attach LSP server lazy-enable to.
--- If left as `nil`, will use corresponding server's filetypes.
---@field filetypes table|nil

--- Conditionally enable an LSP server after checking prerequisites
---
---@param server string LSP server name
---@param opts MaybeEnableOpts
function M.maybe_enable(server, opts)
  if not server then
    vim.notify("Invalid server for maybe_enable", vim.log.levels.ERROR)
    return
  end

  local title = "LSP: " .. server

  if not opts or not opts.check or #opts.check == 0 then
    vim.notify(
      "Missing check command for maybe_enable",
      vim.log.levels.ERROR,
      { title = title }
    )
    return
  end

  -- Prevent leaks upon config reloads (`:source %`), or Neovim restarts
  if registered_servers[server] then
    vim.notify(
      "Already registered",
      vim.log.levels.DEBUG,
      { title = title }
    )
    return
  end

  registered_servers[server] = true

  vim.api.nvim_create_autocmd("FileType", {
    pattern  = (opts.filetypes or (vim.lsp.config[server] or {}).filetypes),
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()

      if bufnr then
        for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          if client.name == server then
            return
          end
        end
      end

      local function warn_missing(err)
        local message = opts.warn
        local details = vim.trim(tostring(err))

        if not message then
          message = string.format("Check failed: %s", table.concat(opts.check, " "))
        end

        if details:match("%S") then
          vim.notify(
            string.format("%s\n\n> %s", message, details),
            vim.log.levels.DEBUG,
            { title = title, timeout = 5000 }
          )
        end

        vim.notify_once(
          message,
          vim.log.levels.WARN,
          { title = title, timeout = 5000 }
        )
      end

      xpcall(
        function()
          vim.system(opts.check, { stderr = true, stdout = false }, function(out)
            vim.schedule(function()
              if out.code ~= 0 then
                warn_missing(out.stderr)
                return
              end

              local ok, err = pcall(vim.lsp.enable, server)

              if not ok then
                vim.notify(
                  string.format("Failed to enable: %s", err),
                  vim.log.levels.ERROR,
                  { title = title, timeout = 5000 }
                )
              end
            end)
          end)
        end,
        function(err)
          vim.schedule(function()
            warn_missing(err)
          end)
        end
      )
    end
  })
end

return M
