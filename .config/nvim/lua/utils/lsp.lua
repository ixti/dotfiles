local M = {}
local J = require("plenary.job")

local registered_servers = {}

local function tail(tbl, offset)
  local slice = {}

  for i = offset, #tbl do
    table.insert(slice, tbl[i])
  end

  return slice
end

--- Conditionally enable an LSP server after checking prerequisites
--- @param server string LSP server name
--- @param opts table Options with
---   `check` (command array, e.g. `{"bundle", "show", "rubocop"}`),
---   `warn` (warning message with short how to fix instructions),
---   `filetypes` (array of filetype patterns).
function M.maybe_enable(server, opts)
  if not server then
    vim.notify("Invalid server for maybe_enable", vim.log.levels.ERROR)
    return
  end

  local title = "LSP: " .. server

  if not opts or not opts.check or #opts.check == 0 then
    vim.notify(
      "Invalid opts for maybe_enable",
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

      local command = opts.check[1]
      local args    = tail(opts.check, 2)

      local function warn_missing()
        local message = opts.warn

        if not message then
          message = string.format("Check failed: %s", table.concat(opts.check, " "))
        end

        vim.notify_once(message, vim.log.levels.WARN, { title = title })
      end

      if vim.fn.executable(command) == 0 then
        warn_missing()
        return
      end

      J:new({
        command = command,
        args    = args,
        on_exit = function(_, status)
          vim.schedule(function()
            if status ~= 0 then
              warn_missing()
              return
            end

            local ok, err = pcall(vim.lsp.enable, server)

            if not ok then
              vim.notify(
                string.format("Failed to enable: %s", err),
                vim.log.levels.ERROR,
                { title = title }
              )
            end
          end)
        end,
      }):start()
    end
  })
end

return M
