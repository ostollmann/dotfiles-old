import XMonad
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import System.IO

main :: IO ()
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/ost/.xmobarrc"
    xmonad $ defaultConfig {
          workspaces = workspaces'
        , terminal = "urxvt"
        , borderWidth = 1
        , normalBorderColor = "#808080"
        , focusedBorderColor = "#d0d0d0"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP {
              ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 80
            , ppSep = xmobarColor "grey" "" " | "
            , ppCurrent = xmobarColor "red" "" . wrap "<" ">"
            , ppHidden = xmobarColor "yellow" ""
            , ppHiddenNoWindows = xmobarColor "yellow" ""
            , ppLayout = const ""
            }
        } `additionalKeys`
        [ 
          ((mod1Mask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod1Mask, xK_r), spawn "dmenu_run")]
    
-- workspaces' = ["2:main","2:web","3:mail","4:chat","5:media","6:misc","*","**","***"]
workspaces' = ["1:main","2:dev","3:web","4:mail","5:cal","6:chat","7:media","8:misc","9:sys"]

-- layout' = Tall 1 (2/3) (5/100) ||| Mirror $ Tall 1 (2/3) (5/100) ||| Full
-- layout' = tiled ||| Mirror tiled ||| Full
--     where 
--         tiled = spacing 3 $ Tall master delta ratio
--         master = 1
--         ratio = 2/3
--         delta = 5/100
