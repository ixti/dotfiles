local noctalia = require("helpers.noctalia")

local CTRL   = "CTRL"
local ALT    = "ALT"
local SHIFT  = "SHIFT"
local SUPER  = "SUPER"

local function bind(combo, ...)
  hl.bind(table.concat(combo, " + "), ...)
end

bind(
  { SUPER, CTRL, "R" },
  noctalia.dsp.restart,
  { description = "Restart Noctalia" }
)

bind(
  { SUPER, "R" },
  hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher toggle"),
  { description = "Open App Launcher" }
)

bind(
  { SUPER, "RETURN" },
  hl.dsp.exec_raw("ghostty"),
  { description = "Open Terminal" }
)

bind({ SUPER, CTRL, "Q" }, hl.dsp.exit())

bind({ SUPER, "N" }, function()
  -- local handle = io.popen("cat /proc/acpi/button/lid/LID*/state 2>/dev/null")
  --
  -- if handle then
  --   local result = handle:read("*a")
  --   handle:close()
  --
  --   if result and string.find(result, "closed") then
  --     hl.dsp.dpms({ action = "off", monitor = "eDP-1" })
  --   else
  --     hl.dsp.dpms({ action = "on", monitor = "eDP-1" })
  --   end
  -- end

  hl.timer(function()
    hl.notification.create({ text = "Disabling eDP-1", duration = 5000 })
    -- hl.dispatch(hl.dsp.dpms({ action = "off", monitor = "eDP-1" }))
    hl.monitor({ output = "eDP-1", disabled = true })

    noctalia.restart()
  end, { timeout = 500, type = "oneshot" })
end)
