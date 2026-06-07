hl.on("hyprland.start", function () 
  hl.exec_cmd("qs -c noctalia-shell")

  -- local handle = io.popen("cat /proc/acpi/button/lid/LID*/state 2>/dev/null")
  -- if handle then
  --   local result = handle:read("*a")
  --   handle:close()
  --
  --   if result and string.find(result, "closed") then
  --     hl.dsp.dpms({ action = "off", monitor = "eDP-1" })
  --   end
  -- end
end)

hl.env("ELECTRON_OZONE_PLATFORM_HINT",        "wayland")
hl.env("QT_QPA_PLATFORM",                     "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("XDG_CURRENT_DESKTOP",                 "Hyprland")
hl.env("XDG_SESSION_TYPE",                    "wayland")

require("includes.10-input")
require("includes.10-monitors")
require("includes.40-cursor")
require("includes.90-binds")
