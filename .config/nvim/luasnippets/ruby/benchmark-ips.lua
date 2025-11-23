local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

local name = "Benchmark IPS"
local trig = "benchmark-ips"
local desc = [[
Generate becnhmark using becnhmark-ips gem.

## Example

```ruby
require "benchmark/ips"

Benchmark.ips do |x|
  x.report("v1") do
    |<-- your cursor here
  end

  x.compare!
end
```
]]

return {
  s({ name = name, trig = trig, desc = desc }, {
    t({
      'require "benchmark/ips"',
      "",
      "Benchmark.ips do |x|",
      '  x.report("v1") do',
      "",
    }),
    t("    "),
    i(0),
    t({
      "",
      "  end",
      "",
      "  x.compare!",
      "end"
    }),
  })
}
