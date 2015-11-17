import Graphics.X11.ExtraTypes.XF86

import XMonad

import XMonad.Actions.GridSelect
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.Search
import XMonad.Actions.UpdateFocus

import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Renamed
import XMonad.Layout.Tabbed

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

import System.IO

import qualified XMonad.StackSet  as W
import qualified Data.Map         as M

import Data.Ratio ((%))


-- TODO: http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-WindowGo.html


-- Based on: http://crunchbang.org/forums/viewtopic.php?pid=89922#p89922
  -- initially created with help of: http://www.haskell.org/haskellwiki/Xmonad/Config_archive/John_Goerzen%27s_Configuration
  -- use "xmonad --recompile" to check it's syntactically correct if making changes (better than just modQ)
  -- list of key codes http://haskell.org/haskellwiki/Xmonad/Key_codes
  -- may also prove useful for some keys and commands http://hackage.haskell.org/packages/archive/X11/1.4.5/doc/html/Graphics-X11-Types.html
  -- may want to encorporate: http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-GridSelect.html
-- See also: https://github.com/league/dot-files/blob/master/xmonad.hs
-- https://github.com/davidbrewer/xmonad-ubuntu-conf/blob/master/xmonad.hs
-- http://www.haskell.org/haskellwiki/Xmonad/Config_archive/Nnoell's_xmonad.hs

myComposeAllHook = (composeAll . concat $
  [ [className =? c --> doShift "9"   | c <- myCommunicators ]
  , [appName   =? c --> doShift "8"   | c <- ["weechat"] ]
  , [className =? c --> doShift "7"   | c <- ["hipchat", "HipChat"] ]
  , [className =? c --> doShift "1"   | c <- myBrowsers ]
  -- , [className =? c --> doFullFloat | c <- myFloatWCs ]
  , [className =? c --> (doRectFloat $ W.RationalRect 0.05 0.05 0.9 0.9) | c <- myFloatWCs ]
  ])
  where
    myCommunicators = ["Pidgin", "Buddy List", "aleksey.zapparov - Skype™", "Psi-plus"]
    myBrowsers      = ["Chromium", "Goofle-chrome", "Iceweasel", "Firefox"]
    myFloatWCs      = ["feh"]

myComposeOneHook = (composeOne [isFullscreen -?> doFullFloat])


myManageHook = manageDocks <+> myComposeAllHook <+> myComposeOneHook


myTerminal    = "x-terminal-emulator"
myWorkspaces  = ["1","2","3","4","5","6","7","8","9","0"]


myResizableTall = (renamed [Replace "Tall"] $ ResizableTall 1 (3/100) (1/2) [])


myTabbed = renamed [Replace "Tabbed"] $ tabbedBottom shrinkText defaultTheme
    { decoHeight = 16
    , activeColor = "#880000"
    , activeBorderColor = "#880000"
    , activeTextColor = "#ffdddd"
    , inactiveColor = "#000000"
    , inactiveBorderColor = "#000000"
    , inactiveTextColor = "#aaaaaa"
    , urgentColor = "#333333"
    , urgentBorderColor = "#333333"
    , urgentTextColor = "#dddddd"
    , fontName = "-misc-fixed-*-*-*-*-12-*-*-*-*-*-*-*"
    }


screenLocker = spawn "i3lock --dpms --color=111111 --ignore-empty-password"


defaultLayouts = smartBorders . avoidStruts
  $ myTabbed ||| myResizableTall ||| Mirror myResizableTall


chatLayout = smartBorders(avoidStruts(withIM (1%7) (roster) Grid))
  where
    roster        = pidginRoster
    pidginRoster  = Title "Buddy List"


layoutHook' =
  ( onWorkspace "9" chatLayout
  $ defaultLayouts
  )


-- get current layout:
-- gets (description . layout . current . windowset) :: X String


myStartupHook = do
  spawn $ concat
    [ "killall trayer ; trayer "
    , "--width 20 --height 16 --expand true --edge top --align right "
    , "--transparent true --alpha 0 --tint 0x000000 "
    , "--SetDockType true --SetPartialStrut true"
    ]


logHook' xmproc = do
  copies <- wsContainingCopies
  let check ws | ws `elem` copies = pad . xmobarColor "red" "black" $ ws
               | otherwise = pad ws

  dynamicLogWithPP $ xmobarPP
    { ppHidden = check
    , ppOutput = hPutStrLn xmproc
    , ppTitle  = xmobarColor "green" "" . shorten 50
    }


menu conf list = gridselect conf list >>= flip whenJust spawn

myMenu = menu defaultGSConfig
    [ ("WeeChat",   "urxvt -name weechat -e dtach -A /tmp/dtach.weechat-curses.sock -r winch weechat-curses")
    , ("Psi+",      "psi-plus")
    , ("deadbeef",  "deadbeef")
    ]

mocMenu = menu defaultGSConfig
    [ ("||>", "setsid mocp --toggle-pause")
    , (">>>", "setsid mocp --seek +15")
    , (">>|", "setsid mocp --next")
    , ("<<<", "setsid mocp --seek -15")
    , ("|<<", "setsid mocp --previous")
    ]

main = do
  xmproc <- spawnPipe "killall xmobar ; HOME=~ xmobar ~/.xmonad/xmobar.hs"
  xmonad $ ewmh desktopConfig
    { modMask           = mod4Mask
    , focusFollowsMouse = True
    , keys              = myKeys
    , terminal          = myTerminal
    , workspaces        = myWorkspaces
    , startupHook       = myStartupHook <+> adjustEventInput <+> setDefaultCursor xC_left_ptr <+> startupHook defaultConfig
    , handleEventHook   = fullscreenEventHook <+> docksEventHook <+> focusOnMouseMove <+> handleEventHook defaultConfig
    , manageHook        = myManageHook <+> manageHook desktopConfig
    , layoutHook        = layoutHook'
    --, logHook           = fadeInactiveCurrentWSLogHook 0.60 >> logHook' xmproc
    , logHook           = logHook' xmproc
    }



myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  -- launch a terminal
  [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

  -- launch dmenu
  , ((modm,               xK_x     ), spawn "dmenu_run -p '>' -nb '#000000' -nf '#ffffff' -sb '#335588' -fn '-*-fixed-medium-r-normal-*-14-*-*-*-*-*-iso10646-1'")

  -- Xonad native shell prompt
  , ((modm .|. shiftMask, xK_x     ), shellPrompt defaultXPConfig {
      font      = "-*-fixed-medium-r-normal-*-14-*-*-*-*-*-iso10646-1",
      bgColor   = "black",
      fgColor   = "white",
      bgHLight  = "grey",
      position  = Top,
      height    = 16,
      promptBorderWidth = 0
    })

  , ((modm,               xK_r     ), myMenu)
  , ((modm,               xK_p     ), mocMenu)
  , ((modm .|. shiftMask, xK_l     ), screenLocker)

  -- change wallpaper
  , ((modm,               xK_w     ), spawn "~/.local/bin/random-wallpaper.sh safe")
  , ((modm .|. shiftMask, xK_w     ), spawn "~/.local/bin/random-wallpaper.sh")

  -- list all windows
  , ((modm,               xK_g     ), goToSelected defaultGSConfig { gs_font = "-*-fixed-medium-r-normal-*-10-*-*-*-*-*-iso10646-1" })
  , ((modm .|. shiftMask, xK_g     ), goToSelected defaultGSConfig { gs_font = "-*-fixed-medium-r-normal-*-10-*-*-*-*-*-iso10646-1" })

  -- calendar
  , ((modm,               xK_c     ), spawn "gsimplecal")

  -- close focused window
  , ((modm .|. shiftMask, xK_c     ), kill)


  -- copy focused window to all workspaces
  , ((modm,               xK_v     ), windows copyToAll)

  -- remove copies of focused window
  , ((modm .|. shiftMask, xK_v     ), killAllOtherCopies)

  --  Rotate through the available layout algorithms
  , ((modm,               xK_space ), sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default
  , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size
  , ((modm,               xK_n     ), refresh)

  -- Move focus to the next window
  , ((modm,               xK_j     ), windows W.focusDown)

  -- Move focus to the previous window
  , ((modm,               xK_k     ), windows W.focusUp  )

  -- Move focus to the master window
  , ((modm,               xK_m     ), windows W.focusMaster )

  -- Swap the focused window and the master window
  , ((modm .|. shiftMask, xK_m     ), windows W.swapMaster )

  -- Swap the focused window with the next window
  , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

  -- Swap the focused window with the previous window
  , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

  -- Shrink the master area
  , ((modm,               xK_h     ), sendMessage Shrink)

  -- Expand the master area
  , ((modm,               xK_l     ), sendMessage Expand)

  -- Push window back into tiling
  , ((modm,               xK_t     ), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area
  , ((modm              , xK_comma ), sendMessage $ IncMasterN 1)

  -- Deincrement the number of windows in the master area
  , ((modm              , xK_period), sendMessage $ IncMasterN (-1))

  -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
  , ((modm,               xK_b     ), sendMessage ToggleStruts)

  -- Change screens
  , ((modm,               xK_Tab   ), nextScreen)
  , ((modm .|. mod1Mask,  xK_Tab   ), swapNextScreen)

  , ((modm,               xK_period), moveTo Next NonEmptyWS)
  , ((modm,               xK_comma ), moveTo Prev NonEmptyWS)

  , ((modm .|. shiftMask, xK_period), nextWS)
  , ((modm .|. shiftMask, xK_comma ), prevWS)
  , ((modm,               xK_slash),  toggleWS)

  -- Restart xmonad
  , ((modm              , xK_q     ), restart "xmonad" True)

  -- Reset screen configureation
  , ((modm .|. shiftMask, xK_BackSpace), spawn "~/.screenlayout/reset.sh")
  ]

  ++

  -- multimedia keys
  [ ((0, xF86XK_Tools),             spawn "setsid xterm mocp")
  , ((0, xF86XK_AudioPlay),         spawn "setsid mocp --toggle-pause")
  , ((0, xF86XK_AudioNext),         spawn "setsid mocp --next")
  , ((0, xF86XK_AudioPrev),         spawn "setsid mocp --previous")
  , ((0, xF86XK_AudioMute),         spawn "~/.local/bin/pavolume.rb toggle")
  , ((0, xF86XK_AudioRaiseVolume),  spawn "~/.local/bin/pavolume.rb up")
  , ((0, xF86XK_AudioLowerVolume),  spawn "~/.local/bin/pavolume.rb down")
  , ((0, xF86XK_Calculator),        spawn "urxvt -e python")
  , ((0, xF86XK_Search),            promptSearch defaultXPConfig google)
  ]

  ++

  --
  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  --
  [ ((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)] ]


