function PP(v)
  print(vim.inspect(v))
end

vim.api.nvim_create_user_command(
  "PP",
  function(opts)
    local chunk, load_err = load("return " .. opts.args)
    if not chunk then
      vim.notify("pp load error: " .. load_err, vim.log.levels.ERROR)
      return
    end

    local ok, result = xpcall(chunk, function(eval_err)
      vim.notify("pp eval error: " .. eval_err, vim.log.levels.ERROR)
    end)

    if not ok then
      return
    end

    print(vim.inspect(result))
  end,
  {
    nargs    = "+",
    complete = "lua",
  }
)
