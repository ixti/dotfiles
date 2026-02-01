local Delimiter = require("plugins.ui.heirline.shared").Delimiter

return {
  Delimiter,

  {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = " %l/%L:%c ",
  },
}
