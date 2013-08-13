import System.IO

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)



startupHook' = do
  spawn $ concat
    [ "killall trayer ; trayer "
    , "--width 15 --height 16 --edge top --align right "
    , "--transparent true --alpha 0 --tint 0x000000 "
    , "--SetDockType true --SetPartialStrut true"
    ]


logHook' xmproc = do
  dynamicLogWithPP $ xmobarPP
    { ppOutput = hPutStrLn xmproc
    , ppTitle  = xmobarColor "green" "" . shorten 100
    }


main = do
  xmproc <- spawnPipe "killall xmobar ; xmobar ~/.xmonad/xmobar.hs"
  xmonad $ ewmh desktopConfig
    { modMask           = mod4Mask
    , focusFollowsMouse = True
    , startupHook       = startupHook' <+> startupHook defaultConfig
    , logHook           = logHook' xmproc
    }
