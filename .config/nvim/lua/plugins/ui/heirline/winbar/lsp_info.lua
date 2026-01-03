local conditions = require("heirline.conditions")

local Delimiter = require("plugins.ui.heirline.winbar.delimiters").west

return {
  condition = conditions.lsp_attached,
  update    = { "LspAttach", "LspDetach" },

  init = function(self)
    local child = {
      { provider = "" },
      Delimiter,
    }

    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(child, { provider = server.name })
      table.insert(child, Delimiter)
    end

    self.child = self:new(child, 1)
  end,

  provider = function(self)
    return self.child:eval()
  end,
}
