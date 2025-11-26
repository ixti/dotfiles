local M = {}

---@type table<string, boolean>
local registered_servers = {}

local CHECK_OPTIONS = {
  text    = true,
  stderr  = true,
  stdout  = false,
  timeout = 5000,
}

local function is_active(server)
  local active_clients = vim.iter(vim.lsp.get_clients())
  local clients_filter = function(client)
    return client.name == server
  end

  return active_clients:any(clients_filter)
end

---@class MaybeEnableOpts
--- If the given command exists with non-zero status, LSP won't be enabled
--- and a warning (see below) will be shown instead.
---@field check table
--- Warning message to show when check command fails.
---@field warn string
--- Fired if server activation failed due to any reason.
---@field on_fail function|nil

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

  if registered_servers[server] or is_active(server) then
    vim.notify(
      "Already registered",
      vim.log.levels.DEBUG,
      { title = title }
    )
    return
  end

  registered_servers[server] = true

  local on_fail = opts.on_fail or (function() end)

  local function warn_missing(err)
    local message = opts.warn
    local details = vim.trim(tostring(err))

    if not message then
      message = string.format("Check failed: %s", table.concat(opts.check, " "))
    end

    if details:match("%S") then
      vim.notify(details, vim.log.levels.DEBUG, { title = title })
    end

    vim.notify(message, vim.log.levels.WARN, { title = title })
  end

  xpcall(
    function()
      vim.system(opts.check, vim.tbl_extend("force", CHECK_OPTIONS, { cwd = vim.loop.cwd() }), function(out)
        vim.schedule(function()
          if out.code ~= 0 then
            warn_missing(out.stderr)
            on_fail()
            return
          end

          local ok, err = pcall(vim.lsp.enable, server)

          if not ok then
            vim.notify(
              string.format("Failed to enable: %s", err),
              vim.log.levels.ERROR,
              { title = title }
            )
            on_fail()
          end
        end)
      end)
    end,
    function(err)
      vim.schedule(function()
        warn_missing(err)
        on_fail()
      end)
    end
  )
end

return M
