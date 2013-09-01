import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Util.Dzen
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.SetWMName

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig
    { terminal    = "lxterminal"
    , startupHook = setWMName "LG3D"
    , modMask     = mod4Mask
    , borderWidth = 3
    } `additionalKeys`
    [ ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 4+ | egrep -o '[0-9]*%' | dzen2 -p 1"),
      ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 4- | egrep -o '[0-9]*%' | dzen2 -p 1")
    ]
