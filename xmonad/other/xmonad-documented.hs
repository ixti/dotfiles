--
-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--

import XMonad
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.Named
import XMonad.Util.Run(spawnPipe)
import Data.Monoid
import Data.Ratio ((%))
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True 
 
-- Width of the window border in pixels.
--
myBorderWidth   = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
 
-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------
 
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1:net","2:dev","3:chat","4:music","5:misc","6:vbox","7:im","8:email","9:logs","0:*"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#5A5A5A"
myFocusedBorderColor = "#FF7700"
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -nb Black -nf Gray -sb Black -sf White ` && eval \"exec $exe\"")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
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
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    
    -- Lock screen
	, ((modm .|. shiftMask	, xK_z	), spawn "xscreensaver-command -lock")
    
    -- Start galculator
    , ((modm				, xK_c	), spawn "galculator")
    
    -- Move to next empty workspace
    , ((modm				, xK_m	), viewEmptyWorkspace)
    
    -- Move focused window to next empty workspace and view
    , ((modm .|. shiftMask	, xK_m	), tagToEmptyWorkspace)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    
    -- Multimedia keys
    --
    -- Volume Up
    , ((0, xF86XK_AudioRaiseVolume	), spawn "amixer sset Master 1%+")
    -- Volume Down
    , ((0, xF86XK_AudioLowerVolume	), spawn "amixer sset Master 1%-")
    -- Mute On/Off
    , ((0, xF86XK_AudioMute			), spawn "amixer sset Master toggle")
    -- Play/Pause
    , ((0, xF86XK_AudioPlay			), spawn "gmusicbrowser -launch_or_cmd PlayPause")
    -- Next
    , ((0, xF86XK_AudioNext			), spawn "gmusicbrowser -remotecmd NextSong")
    -- Previous
    , ((0, xF86XK_AudioPrev			), spawn "gmusicbrowser -remotecmd PrevSong")
    -- Stop
    , ((0, xF86XK_AudioStop			), spawn "gmusicbrowser -remotecmd Stop")
    -- Lock screen
    , ((0, xF86XK_Sleep				), spawn "gmusicbrowser -remotecmd Stop && xscreensaver-command -lock")
    -- Calculator
    , ((0, xF86XK_Calculator		), spawn "galculator")
    , ((0, xF86XK_Documents         ), spawn "beagle-search")
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
basicLayout = Tall nmaster delta ratio where
    nmaster = 1
    delta   = 3/100
    ratio   = 2/3
wideLayout = smartBorders(	named "wide"	$ Mirror basicLayout )
tallLayout = smartBorders(	named "tall"	$ basicLayout )
tabbedLayout = noBorders(	named "fulltab"	$ simpleTabbed )
imLayout = smartBorders(	named "im"		$ reflectHoriz $ gridIM (1%5) (Role "buddy_list"))

myLayout = (wideLayout ||| tallLayout ||| tabbedLayout ||| imLayout)

 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Vlc"                         --> doFloat
    , className =? "Gimp"                        --> doFloat
    , className =? "Galculator"                  --> doFloat
    , className =? "Xmessage"                    --> doFloat
    , className =? "Select Font"				 --> doFloat
    , className =? "gtk-chtheme"				 --> doFloat
    , className =? "search"                      --> doFloat
    , className =? "Firefox Preferences"		 --> doFloat
    , className =? "Firefox"					 --> doShift "1:net"
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "Gedit"                       --> doShift "1:net"
    , className =? "Eclipse"                     --> doShift "2:dev"
    , className =? "Geany"                       --> doShift "2:dev"
    , className =? "Gvim"						 --> doShift "2:dev"
    , className =? "Xchat"						 --> doShift "3:chat"
    , className =? "Gmusicbrowser"               --> doShift "4:music"
    , className =? "net-minecraft-LauncherFrame" --> doShift "5:misc"
    , className =? "crawl-tiles"                 --> doShift "5:misc"
    , className =? "VirtualBox"                  --> doShift "6:vbox"
    , className =? "Pidgin"						 --> doShift "7:im"
    , className =? "Skype"                       --> doShift "7:im"
    , className =? "Thunderbird"				 --> doShift "8:email"
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Gvim" --> (ask >>= \w -> liftX (setOpacity w 0xBFFFFFFF) >> idHook)
    , manageDocks
    ]
 
------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return()
 
------------------------------------------------------------------------
-- My StatusBar

--
-- Initialize all variables here that will be passed onto xmonad
-- to start the StatusBar.
-- myBar			- Command used to run xmobar, prefer cusutom script over args here
-- myPP				- Custom appearance, XMonad.Hooks.DyanmicLog Doumentation for more
-- toggetstrutsKey	- Keybinding to pass along with it all, toggles visibility
--

myBar = "xmobar /home/kofrad/.xmobarrc"
myPP = xmobarPP { ppCurrent	= xmobarColor "#FFFFFF" "" . wrap "[" "]",
	--ppHiddenNoWindows		= xmobarColor "#5A5A5A" "",
	ppUrgent				= xmobarColor "#FFFFFF" "#FF0000" . wrap "" "*" . xmobarStrip,
	ppTitle					= xmobarColor "#FF7700" "" . shorten 50,
	ppSep					= " | "
	}
toggleStrutsKey XConfig {XMonad.modMask = myMmodMask} = (myModMask, xK_b)

------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = return ()
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
-- The main function.

main = xmonad =<< statusBar myBar myPP toggleStrutsKey (withUrgencyHook NoUrgencyHook $ myConfig)
    
myConfig = defaultConfig {
  -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    -- numlockMask deprecated in 0.9.1
    -- numlockMask        = myNumlockMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
 
  -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

  -- hooks, layouts
    layoutHook         = avoidStruts $ myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook	       = myLogHook,
    startupHook        = myStartupHook
}