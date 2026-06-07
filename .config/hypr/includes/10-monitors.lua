local noctalia = require("helpers.noctalia")

hl.monitor({
  output   = "desc:Lenovo Group Limited 0x4146",
  mode     = "3840x2400@60.000",
  position = "auto",
  scale    = 2.4,
})

hl.monitor({
  output   = "desc:Dell Inc. DELL U2720Q FDX4T83",
  mode     = "3840x2160@59.997",
  position = "auto",
  scale    = 2.0,
})

hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})

hl.bind(
  "switch:on:Lid Switch",
  function()
    hl.monitor({ output = "eDP-1", disabled = true })
    noctalia.restart()
  end,
  { locked = true }
)

hl.bind(
  "switch:off:Lid Switch",
  function()
    hl.monitor({ output = "eDP-1", disabled = false })
    noctalia.restart()
  end,
  { locked = true }
)
