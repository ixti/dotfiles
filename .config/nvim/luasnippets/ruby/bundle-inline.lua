local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

local name = "Inline Bundler"
local trig = "bundle-inline"
local desc = [[
Generate inline bundler gemfile.

## Example

```ruby
require "bundler/inline"

gemfile do
  source "https://gem.coop"

  gem "debug"
end
```
]]

return {
  s({ name = name, trig = trig, desc = desc }, {
    t({
      'require "bundler/inline"',
      "",
      "gemfile do",
      '  source "https://gem.coop"',
      "",
      '  gem "debug"',
      "",
    }),
    t("  "),
    i(0),
    t({
      "",
      "end",
      "",
    }),
  })
}
