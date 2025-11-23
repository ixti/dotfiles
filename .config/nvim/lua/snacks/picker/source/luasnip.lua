return {
  title = "LuaSnip",

  finder = function()
    local items = {}

    for i, snippet in ipairs(require("luasnip").get_snippets(vim.bo.filetype)) do
      items[i] = {
        text    = Snacks.picker.util.text(snippet, { "trigger", "name", "description" }),
        title   = (snippet.name or snippet.trigger),
        snippet = snippet
      }
    end

    return items
  end,

  preview = function(item, ctx)
    if not item or not item.snippet then
      return nil
    end

    local snippet = item.snippet

    return table.concat(
      vim.tbl_flatten({
        "# " .. snippet.name,
        (snippet.description or "*missing description*")
      }),
      "\n\n"
    )
  end,

  format = function(item)
    return {
      { item.title, "Title" },
    }
  end,

  confirm = function(picker, item)
    if not item then return end

    picker:close()

    vim.schedule(function()
      require("luasnip").snip_expand(item.snippet)
    end)
  end,
}
