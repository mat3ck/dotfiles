
-- sys
import System.Exit

-- base
import XMonad
import qualified Data.Map
import XMonad.Util.EZConfig ( additionalKeys )
import XMonad.Prompt.ConfirmPrompt

myTerminal = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myBorderWidth = 2
myModMask = mod4Mask

myKeys =
    -- launch rofi
    [ (( mod4Mask,                  xK_p), spawn "rofi -theme base16-material -show run")
    , (( mod4Mask .|. shiftMask,    xK_q), confirmPrompt def "exit" $ io (exitWith ExitSuccess))
    ]


main = xmonad defaults

defaults = def {
        terminal            = myTerminal,
        focusFollowsMouse    = myFocusFollowsMouse,
        borderWidth         = myBorderWidth,
        modMask             = myModMask
    } `additionalKeys` myKeys

