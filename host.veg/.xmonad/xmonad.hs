--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

--
-- XMonad core
--
-- These `import`s can be replaced with only one `import XMonad` line.
--

--import XMonad
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-Main.html
    -- (XMonad.Main has only `xmonad`.)
    -- xmonad: The main entry point.
import XMonad.Main(xmonad)
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-Config.html
    -- (XMonad.Config has only `defaultConfig`.)
    -- defaultConfig: The default set of configuration values itself.
import XMonad.Config(defaultConfig)
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-Layout.html
    -- Full: Simple fullscreen mode.
    --       -> use MultiToggle instead.
    -- Tall: The builtin tiling mode of xmonad.
    --       -> use HintedTile instead.
    -- Mirror: Mirror a layout, compute its 90 degree rotated form.
    --         -> use MultiToggle instead.
    -- (|||): The layout choice combinator.
    -- ChangeLayout: Messages to change the current layout.
    --   FirstLayout, NextLayout
    -- IncMasterN: Increase the number of clients in the master pane.
    -- Resize: Change the size of the master pane.
    --   Shrink, Expand
--import XMonad.Layout(Full(Full), Tall(Tall), Mirror(Mirror))
import XMonad.Layout((|||), ChangeLayout(NextLayout), IncMasterN(IncMasterN), Resize(Shrink, Expand))
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-ManageHook.html
    -- composeAll: Compose the list of `ManageHook`s.
    -- doFloat: Move the window to the floating layer.
    -- doIgnore: Map the window and remove it from the `WindowSet`.
    -- className: Return the resource class.
    -- appName: Return the window title.
    --   (resource: Backward compatible alias for `appName`.)
    -- title: Return the window title.
    -- stringProperty: A query that can be return an arbitrary X property of type `String`, identified by name.
    -- (<+>): Infix `mappend`. Compose two `ManageHook` from right to left.
    -- (=?): `q =? x`. If the result of `q` equals `x`, return `True`.
    -- (-->): `p --> x`. If `p` returns `True`, execute the `ManageHook`.
    -- (<&&>): `&&` lifted to a `Monad`.
import XMonad.ManageHook(composeAll, doFloat, doIgnore, className, appName, title, stringProperty, (<+>), (=?), (-->), (<&&>))
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-Operations.html
    -- sendMessage: Throw a message to the current LayoutClass possibly modifying how we layout the windows, then refresh.
    -- focus: Set focus explicitly to window w if it is managed by us, or root.
    -- windows: Modify the current window list with a pure function, and refresh.
    -- kill: Kill the currently focused client.
    -- setLayout: Set the layout of the currently viewed workspace.
    -- refresh: Render the currently visible workspaces, as determined by the StackSet. Also, set focus to the focused window.
    -- withFocused: Apply an X operation to the currently focused window, if there is one.
    -- screenWorkspace: Return workspace visible on screen sc, or Nothing.
    -- mouseMoveWindow: (Poorly documented)
    -- mouseResizeWindow: (Poorly documented)
import XMonad.Operations(sendMessage, focus, windows, kill, setLayout, refresh, withFocused, screenWorkspace, mouseMoveWindow, mouseResizeWindow)
    -- https://hackage.haskell.org/package/base-4.8.1.0/docs/Data-Bits.html
    -- (.|.): Bitwise "or".
import Data.Bits ((.|.))
    -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-Xlib-Types.html
    -- Rectangle: Counterpart of an X11 XRectangle structure.
import Graphics.X11.Xlib.Types(Rectangle(Rectangle, rect_height))
    -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-Types.html
    -- Graphics.X11.Types: A collection of type declarations for interfacing with X11.
    --   (This module has many basic key symbols (e.g. xK_Return))
import Graphics.X11.Types
    -- https://hackage.haskell.org/package/transformers-0.4.3.0/docs/Control-Monad-IO-Class.html
    -- MonadIO: Monads in which IO computations may be embedded.
    -- liftIO: Lift a computation from the IO monad.
    --   (liftIO :: IO a -> m a)
import Control.Monad.IO.Class(MonadIO, liftIO)
    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-Core.html
    -- X: `X` monad, `ReaderT` and `StateT` transformers over `IO`
    --    encapsulating the window manager configuration and state, respectively.
    -- XConfig: User configuration.
    -- spawn: Launch an external application. Specifically, it double-forks and runs the `String` you pass as a command to `/bin/sh`.
    -- io: Lift an `IO` action into the `X` monad.
    --   (io :: MonadIO m => IO () -> m ())
    -- whenJust: Conditionally run an action, using a `Maybe a` to decide.
    --   (whenJust :: Monad m => Maybe a -> (a -> m ()) -> m ())
    -- whenX: Conditionally run an action, using a X event to decide
    --   (whenX :: X Bool -> X () -> X ())
import XMonad.Core(X, XConfig(..), spawn, io, whenJust, whenX)
import qualified XMonad.Core as XMonad (workspaces, layoutHook, modMask, terminal)

--
-- Other required modules
--

    -- http://xmonad.org/xmonad-docs/xmonad/XMonad-StackSet.html
    -- XMonad.StackSet: The StackSet data type encodes a window manager abstraction.
import qualified XMonad.StackSet as W
    -- https://hackage.haskell.org/package/containers-0.5.6.3/docs/Data-Map.html
    -- fromList: Build a map from a list of key/value pairs.
    --   (fromList :: Ord k => [(k, a)] -> Map k a)
import qualified Data.Map        as M (fromList)

--
-- System
--

    -- https://hackage.haskell.org/package/base-4.8.1.0/docs/System-Exit.html
    -- ExitCode: Defines the exit codes that a program can return.
    --   ExitSuccess, ExitFailure Int
    -- exitWith: Computation exitWith code throws ExitCode code.
    --           Normally this terminates the program, returning code to the program's caller.
import System.Exit(ExitCode(ExitSuccess), exitWith)
    -- https://hackage.haskell.org/package/base-4.8.1.0/docs/System-IO.html
    -- hClose: Computation `hClose hdl` makes handle `hdl` closed. Before the computation finishes,
    --         if `hdl` is writable its buffer is flushed as for `hFlush`.
import System.IO(hClose)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Run.html
    -- spawnPipe: Launch an external application through the system shell and return a Handle to its standard input.
    -- hPutStr: Computation `hPutStr hdl s` writes the string `s` to the file or channel managed by `hdl`.
    -- hPutStrLn: The same as hPutStr, but adds a newline character.
    -- runProcessWithInput: Returns the output.
    --   (runProcessWithInput :: MonadIO m => FilePath -> [String] -> String -> m String)
import XMonad.Util.Run(spawnPipe, hPutStrLn, runProcessWithInput)

--
-- Algorithms
--

    -- https://hackage.haskell.org/package/base-4.8.1.0/docs/Control-Monad.html
    -- liftM: Promote a function to a monad.
    --   (liftM :: Monad m => (a1 -> r) -> m a1 -> m r
import Control.Monad(liftM)
    -- https://hackage.haskell.org/package/base-4.8.1.0/docs/Data-Char.html
    -- toLower: Convert a letter to the corresponding lower-case letter, if any.
import Data.Char(toLower)

--
-- Hooks
--

    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-DynamicLog.html
    -- dynamicLogWithPP: Format the current status using the supplied pretty-printing format, and write it to stdout.
    -- PP: The `PP` type allows the user to customize the formatting of status information.
    -- xmobarPP: Some nice xmobar defaults.
    -- xmobarColor: Use xmobar escape codes to output a string with given foreground and background colors.
    -- wrap: Wrap a string in delimiters, unless it is empty.
    -- shorten: Limit a string to a certain length, adding "..." if truncated.
    -- statusBar: Modifies the given base configuration to launch the given status bar,
    --            send status information to that bar, and allocate space on the screen edges for the bar.
import XMonad.Hooks.DynamicLog(dynamicLogWithPP, PP(..), xmobarPP, xmobarColor, wrap, shorten, statusBar)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-ManageDocks.html
    -- manageDocks: Detects if the given window is of type DOCK and if so, reveals it, but does not manage it.
import XMonad.Hooks.ManageDocks(manageDocks)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-SetWMName.html
    -- setWMName: Sets WM name.
    --   see http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-SetWMName.html for detail.
import XMonad.Hooks.SetWMName(setWMName)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-EwmhDesktops.html
    -- XMonad.Hooks.EwmhDesktops: Makes xmonad use the EWMH hints to tell panel applications
    --                            about its workspaces and the windows therein. It also allows the user
    --                            to interact with xmonad by clicking on panels and window lists.
    -- ewmhDesktopsStartup: Initializes EwmhDesktops and advertises EWMH support to the X server.
    -- ewmhDesktopsEventHook: Intercepts messages from pagers and similar applications and reacts on them.
    -- ewmhDesktopsLogHook: Notifies pagers and window lists,
    --                      such as those in the gnome-panel of the current state of workspaces and windows.
    -- ewmh: Add EWMH functionality to the given config.
import XMonad.Hooks.EwmhDesktops(ewmhDesktopsStartup, ewmhDesktopsEventHook, ewmhDesktopsLogHook, ewmh)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Hooks-InsertPosition.html
    -- insertPosition: A manage hook for placing new windows.
    --                 XMonad's default is the same as using: `insertPosition Above Newer`.
    -- Focus:
    --   Newer, Older
    -- Position:
    --   Master, End, Above, Below
import XMonad.Hooks.InsertPosition(insertPosition, Position(Below), Focus(Older))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-NoBorders.html
    -- smartBorders: Removes the borders from a window under one of the following conditions:
    --                 - There is only one screen and only one window.
    --                   In this case it's obvious that it has the focus, so no border is needed.
    --                 - A floating window covers the entire screen (e.g. mplayer).
    --   Note that on a Xinerama setup, the former condition will never be true.
    -- noBorders: Removes all window borders from the specified layout.

--
-- Layouts
--

import XMonad.Layout.NoBorders(smartBorders, noBorders)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-Magnifier.html
    -- XMonad.Layout.Magnifier: This is a layout modifier that will make a layout increase
    --                          the size of the window that has focus.
import qualified XMonad.Layout.Magnifier as Mag
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-MultiToggle.html
    -- Toggle: Toggle the specified layout transformer.
    -- mkToggle1: Construct a MultiToggle layout from a single transformer and a base layout.
import qualified XMonad.Layout.MultiToggle as Mt (Toggle(Toggle), mkToggle1)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-MultiToggle-Instances.html
    -- StdTransformers:
    --   FULL: Switch to Full layout.
    --   NBFULL: Switch to Full with no borders.
    --   MIRROR: Mirror the current layout.
    --   NOBORDERS: Remove borders.
    --   SMARTBORDERS: Apply smart borders.
import XMonad.Layout.MultiToggle.Instances(StdTransformers(MIRROR, NBFULL))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-ThreeColumns.html
    -- ThreeCol: Arguments are nmaster, delta, fraction.
    --   (ThreeColMid, ThreeCol)
    --   (Arguments are same as `XMonad.Config.Tall`.)
import XMonad.Layout.ThreeColumns(ThreeCol(ThreeCol))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-Renamed.html
    -- renamed: Apply a list of `Rename` values to a layout, from left to right.
    --   (renamed :: [Rename a] -> l a -> ModifiedLayout Rename l a)
    -- Rename: The available renaming operations.
    --   CutLeft Int, CutRight Int,
    --   Append String, Prepend String,
    --   CutWordsLeft Int, CutWordsRight Int,
    --   AppendWords String, PrependWords String,
    --   Replace String,
    --   Chain [Rename a]
import XMonad.Layout.Renamed(renamed, Rename(Replace))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-Tabbed.html
    -- tabbed: A layout decorated with tabs and the possibility to set a custom shrinker and theme.
    -- shrinkText: (Poorly documented.)
    --   (shrinkText :: DefaultShrinker)
    -- Theme: A Theme is a record of colors, font etc., to customize a `DecorationStyle`.
import XMonad.Layout.Tabbed(tabbed, shrinkText, Theme(fontName))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-HintedTile.html
    -- HintedTile:
    -- Alignmnt:
    --   TopLeft, Center, BottomRight
    -- Orientation:
    --   Wide: Lay out windows similarly to Mirror tiled.
    --   Tall: Lay out windows similarly to tiled.
import qualified XMonad.Layout.HintedTile as Ht (HintedTile(HintedTile), Alignment(Center), Orientation(Tall))

--
-- Utils
--

    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html
    -- additionalKeys: Add or override keybindings from the existing set.
    --   (additionalKeys :: XConfig a -> [((ButtonMask, KeySym), X ())] -> XConfig a)
--import XMonad.Util.EZConfig(additionalKeys)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Dmenu.html
    -- dmenu: Run dmenu to select an option from a list.
import XMonad.Util.Dmenu(dmenu)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-WorkspaceCompare.html
    -- getSortByXineramaRule: Sort serveral workspaces for xinerama displays,
    --                        in the same order produced by pprWindowSetXinerama:
    --                        first visible workspaces, sorted by screen, then hidden workspaces, sorted by tag.
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)
    -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-Xlib.html
    -- openDisplay: interface to the X11 library function XOpenDisplay().
    --   (openDisplay :: String -> IO Display)
import Graphics.X11.Xlib(openDisplay)
    -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-Xinerama.html
    -- getScreenInfo: Wrapper around xineramaQueryScreens that fakes a single screen when Xinerama is not active.
    --                This is the preferred interface to Graphics.X11.Xinerama.
    --   (getScreenInfo :: Display -> IO [Rectangle])
import Graphics.X11.Xinerama(getScreenInfo)
    -- http://xmonad.org/xmonad-docs/X11/Graphics-X11-ExtraTypes-XF86.html
    -- This file is generated based on X.org includes. It contains the keysyms for XF86.
import Graphics.X11.ExtraTypes.XF86
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-GridSelect.html
    -- defaultGSConfig: A basic configuration for `gridselect`, with the colorizer chosen based on the type.
    -- gridselectWindow: Like `gridSelect` but with the current windows and their titles as elements.
    --   (gridselectWindow :: GSConfig Window -> X (Maybe Window))
    -- gridselect: Brings up a 2D grid of elements in the center of the screen,
    --             and one can select an element with cursors keys. The selected element is returned.
    --   (gridselect :: GSConfig a -> [(String, a)] -> X (Maybe a))
    -- gridselectWorkspace: Select a workspace and view it using the given function (normally view or greedyView)
    --   (gridselectWorkspace :: GSConfig WorkspaceId -> (WorkspaceId -> WindowSet -> WindowSet) -> X ())
    -- runSelectedAction: Select an action and run it in the X monad.
import XMonad.Actions.GridSelect(defaultGSConfig, gridselectWindow, runSelectedAction, gridselectWorkspace)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Paste.html
    -- pasteString: Send a string to the window which is currently focused. This function correctly handles capitalization.
    --   (NOTE: This does not properly send whitespace characters.)
    --import XMonad.Util.Paste(pasteString)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Prompt.html
    -- XPConfig:
    -- mkComplFunFromList: This function takes a list of possible completions
    --                     and returns a completions function to be used with `mkXPrompt`
    --   (NOTE: Completion created by this function is used with `inputPromptWithCompl`.
    --   (mkComplFunFromList :: [String] -> String -> IO [String])
    -- mkComplFunFromList': This function takes a list of possible completions
    --                      and returns a completions function to be used with `mkXPrompt`
    --                      If the string is null it will return all completions.
import XMonad.Prompt(XPConfig(font), mkComplFunFromList')
    -- amberXPConfig:
    --   (amberXPConfig :: XPConfig)
import XMonad.Prompt(amberXPConfig)
    -- greenXPConfig:
    --   (greenXPConfig :: XPConfig)
--import XMonad.Prompt(greenXPConfig)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Prompt-Shell.html
    -- shellPrompt:
    --   (shellPrompt :: XPConfig -> X ())
import XMonad.Prompt.Shell(shellPrompt)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Prompt-Input.html
    -- inputPrompt: Given a prompt configuration and some prompt text,
    --              create an X action which pops up a prompt waiting for user input, and returns whatever they type.
    --   (inputPrompt :: XPConfig -> String -> X (Maybe String))
    -- The same as inputPrompt, but with a completion function.
    --   (inputPromptWithCompl :: XPConfig -> String -> ComplFunction -> X (Maybe String))
    -- (?+): A combinator for hooking up an input prompt action to a function
    --       which can take the result of the input prompt and produce another action.
    --   ((?+) :: Monad m => m (Maybe a) -> (a -> m ()) -> m ())
import XMonad.Prompt.Input(inputPromptWithCompl, (?+))
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-Themes.html
    -- ThemeInfo:
    -- robertTheme, donaldTheme, wfarrTheme:
    --   (fooTheme :: ThemeInfo)
    --import XMonad.Util.Themes(theme, robertTheme, donaldTheme, wfarrTheme)
import XMonad.Util.Themes(ThemeInfo(theme), robertTheme)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-Submap.html
    -- submap: Given a `Map` from key bindings to `X ()` actions,
    --         return an action which waits for a user keypress and executes the corresponding action,
    --         or does nothing if the key is not found in the map.
    -- submapDefault: Like `submap`, but executes a default action if the key did not match.
import XMonad.Actions.Submap(submap)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-DynamicWorkspaces.html
    -- removeWorkspace: Remove the current workspace.
    -- selectWorkspace:
    -- withWorkspace:
    -- renameWorkspace:
import XMonad.Actions.DynamicWorkspaces(removeWorkspace, selectWorkspace, withWorkspace, renameWorkspace)
    -- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Actions-CopyWindow.html
    -- copy: Copy the focused window to a workspace.
import XMonad.Actions.CopyWindow(copy)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "mlterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["terminal", "web"] ++ map show [3..9] ++ ["bg"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- Xft font.
myXftFont = "xft:VL Gothic"
sizedXftFont :: Int -> String
sizedXftFont size = myXftFont ++ ":size=" ++ show size

-- XMonad Prompt config.
myXPConfig = amberXPConfig { font = sizedXftFont 9 }
--myXPConfig = greenXPConfig { font = sizedXftFont 9 }

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myToggleStrutsKey XConfig { XMonad.modMask = modm } = (modm , xK_b)
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    --, ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    --, ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

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
    -- NOTE: Use statusBar and myToggleStrutsKey instead.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_q     ), exitWithConfirm ExitSuccess)

    -- Restart xmonad
    -- `xmonad --restart` may automatically recompile this configure file.
    , ((modm              , xK_q     ), spawn "LANG=C xmonad --recompile && xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), messageBox "help" help)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    --
    -- larry's setting
    --
    ++
    -- 'L'ock screen
    [ ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command -lock")
    -- Capture window
    , ((0                 , xK_Print ), spawn "import -frame ~/Pictures/screenshots/`date '+screenshot-%Y-%m-%d-%H%M%S%z.png'`")
    -- Capture screen
    --, ((modm              , xK_Print ), spawn "import -screen ~/Pictures/`date '+screenshot-%Y-%m-%d-%H%M%S%z.png'`")
    , ((modm              , xK_Print ), spawn "scrot -m 'screenshot-%Y-%m-%d-%H%M%S%z.png' -e 'mv $f ~/Pictures/screenshots/'")
    -- Run 'F'iler
    --, ((modm              , xK_f     ), spawn "nautilus --new-window")
    , ((modm              , xK_f     ), spawn "thunar")
    -- Run 'F'iler as root
    , ((modm .|. shiftMask, xK_f     ), spawn "gksu thunar")
    -- 'Q'uit xmonad without warning
    , ((modm .|. shiftMask .|. controlMask, xK_q ), io (exitWith ExitSuccess))
    -- Eject DVD
    , ((0                 , xF86XK_Eject ), spawn "eject -T /dev/sr0")
    ]

    --
    -- settings for laptop
    --
    -- ++
    -- [ ((0                 , xF86XK_MonBrightnessUp ), spawn "xbacklight -steps 1 -inc 9")
    -- , ((0                 , xF86XK_MonBrightnessDown ), spawn "xbacklight -steps 1 -dec 9")
    -- ]

    --
    -- volume control
    --
    ++
    [ ((0                 , xF86XK_AudioMute ), spawn "~/scripts/local/volumecontrol.sh toggle")
    , ((0                 , xF86XK_AudioRaiseVolume ), spawn "~/scripts/local/volumecontrol.sh 1%+")
    , ((0                 , xF86XK_AudioLowerVolume ), spawn "~/scripts/local/volumecontrol.sh 1%-")
    ]

    --
    -- MPD control
    --
    ++
    [ ((0                 , xF86XK_AudioPause ), spawn "~/scripts/local/mpd.sh toggle_pause")
    , ((modm              , xK_Pause ), spawn "~/scripts/local/mpd.sh toggle_pause")
    , ((modm              , xF86XK_AudioRaiseVolume ), spawn "~/scripts/local/mpd.sh set_volume '+3'")
    , ((modm              , xF86XK_AudioLowerVolume ), spawn "~/scripts/local/mpd.sh set_volume '-3'")
    , ((0                 , xF86XK_AudioPlay ), spawn "~/scripts/local/mpd.sh set_play_status play")
    , ((0                 , xF86XK_AudioStop ), spawn "~/scripts/local/mpd.sh set_play_status stop")
    , ((0                 , xF86XK_AudioPrev ), spawn "~/scripts/local/mpd.sh play previous")
    , ((0                 , xF86XK_AudioNext ), spawn "~/scripts/local/mpd.sh play next")
    , ((modm .|. shiftMask, xK_Pause ), spawn "~/scripts/local/mpd.sh play next")
    ]

    --
    -- window layout control
    --
    ++
    -- Increase magnification rate
    -- Shift-= => '+'
    [ ((modm              , xK_equal ), sendMessage Mag.MagnifyMore)
    -- Decrease magnification rate
    , ((modm              , xK_minus ), sendMessage Mag.MagnifyLess)
    -- Toggle magnification ('S'caling) on/off
    , ((modm              , xK_s ), sendMessage Mag.Toggle)
    -- Toggle full
    , ((modm              , xK_F12 ), sendMessage $ Mt.Toggle NBFULL)
    -- Toggle vertical and horizontal ('M'irror)
    , ((modm .|. controlMask, xK_m ), sendMessage $ Mt.Toggle MIRROR)
    -- Select window and focus ('G'rid)
    , ((modm              , xK_g ),
        gridselectWindow defaultGSConfig
        >>= flip whenJust (\w -> focus w >> windows (W.focusWindow w))
      )
    ]

    --
    -- clipboard
    --
    -- ++
    -- Paste from clipboard, not from selection
    -- (Paste from selection with Shift-Insert)
    -- NOTE: `pasteString` は空白文字を無視するようなので、現状では意図したようにpasteできない。
    -- [ ((controlMask       , xK_Insert ), runProcessWithInput "xsel" ["--clipboard", "--output"] "" >>= pasteString)
    -- , ((modm              , xK_Insert ), runProcessWithInput "xsel" ["--clipboard", "--output"] "" >>= pasteString)
    -- ]

    --
    -- Dynamic workspace control
    --
    ++
    -- Remove workspace
    [ ((modm .|. shiftMask, xK_BackSpace), removeWorkspace)
    -- Select workspace with prompt
    , ((modm .|. shiftMask, xK_v        ), selectWorkspace myXPConfig)
    -- Select workspace with gridselect
    , ((modm .|. controlMask, xK_v      ), gridselectWorkspace defaultGSConfig W.greedyView)
    -- 'W'orkspace operations
    , ((modm .|. controlMask, xK_w      ), submap . M.fromList $
      -- 'M'ove selected window to another workspace
      [ ((modm                , xK_m      ), withWorkspace myXPConfig (windows . W.shift))
      -- 'C'opy window to another workspace
      , ((modm                , xK_c        ), withWorkspace myXPConfig (windows . copy))
      ])
    -- Rename current workspace
    , ((modm .|. shiftMask, xK_r        ), renameWorkspace myXPConfig)
    ]

    --
    -- other
    --
    ++
    -- 'S'hell prompt on the bottom of the screen.
    [ ((modm .|. shiftMask, xK_s ), shellPrompt myXPConfig)
    -- Select frequently used applications with grid.
    , ((modm              , xK_Tab ), runSelectedAction defaultGSConfig
        [ ("firefox"        , spawn "firefox")
        , ("thunderbird"    , spawn "thunderbird")
        , ("thunar"         , spawn "thunar")
        , ("pavucontrol"    , spawn "pavucontrol")
        , ("arandr"         , spawn "arandr")
        ]
      )
    -- Select an existing session with grid.
    , ((modm              , xK_semicolon), mltermAttachTmuxSession)
    -- Specify session to attach or create with prompt.
    , ((modm .|. shiftMask, xK_semicolon), tmuxSessionPrompt)
    ]

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
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
--myLayout = tiled ||| Mirror tiled ||| Full
myLayout =
    Mt.mkToggle1 NBFULL
    $ Mt.mkToggle1 MIRROR
    -- Do not show window border when there is only one window shown.
    $ smartBorders
    -- Avoid covering docks (status bars)
    -- XMonad.Config.DesktopのdesktopLayoutModifiersを使うと、MultiToggleのMIRRORで何故か横幅がおかしくなる。
    -- $ desktopLayoutModifiers
    -- I want ``ModifiedLayout (Mag (1.2, 1.2) Off NoMaster)``
    -- (1.2x1.2 size, default off, master is not magnified),
    -- but ModifiedLayout, Mag, Off and NoMaster aren't exported.
    $ (mag $ tiled)
    ||| (mag $ threeCol)
    ||| renamed [Replace "tabbed"] (tabbed shrinkText tabbedLayout)
    where
       -- default tiling algorithm partitions the screen into two panes
       --tiled   = Tall nmaster delta ratio
       -- Hinted tile
       tiled   = Ht.HintedTile nmaster delta ratio Ht.Center Ht.Tall

       -- Three column
       threeCol = ThreeCol nmaster delta ratio

       -- Magnifier
       mag = Mag.magnifiercz' 1.1

       -- Theme for tabbed layout
       tabbedLayout = (theme robertTheme) { fontName = sizedXftFont 8 }
       --tabbedLayout = (theme donaldTheme) { fontName = sizedXftFont 8 }
       --tabbedLayout = (theme wfarrTheme) { fontName = sizedXftFont 8 }

       -- No border for full screen window
       --full    = noBorders Full

       -- The default number of windows in the master pane
       nmaster = 1

       -- Default proportion of screen occupied by master pane
       ratio   = 1/2

       -- Percent of screen to increment by when resizing panes
       delta   = 3/100

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
-- 'className' and 'appName' are used below.
--
myManageHook = composeAll . concat $
    -- Open new window after active window and don't change active window.
    [ [insertPosition Below Older]
    , [manageDocks]
    , [manageHook defaultConfig]
    , [ className =? c --> doFloat | c <- myFloats ]
    , [ appName  =? r --> doIgnore | r <- myIgnores ]
    , [ className =? "Firefox" <&&> appName =? "Dialog" --> doFloat ]
    , [ className =? "Gkrellm" <&&> appName =? "Gkrellm_conf" --> doFloat ]
    , [ className =? "Thunar" <&&> title =? "ファイル操作進行中" --> doFloat ]
    , [ role =? r  --> doFloat | r <- myFloatRole ]
    ]
    where
      myFloats = ["MPlayer", "Conky", "Tilda", "Zenity", "StepMania", "Qjackctl"]
      myIgnores = ["desktop_window", "kdesktop"]
      myFloatRole = ["gimp-message-dialog"]
      role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
--myEventHook = mempty
myEventHook = ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = return ()
myLogHook = ewmhDesktopsLogHook
myXmobarPP = xmobarPP
        { ppCurrent = xmobarColor "#ffff00" "" . wrap "[" "]"
        , ppTitle   = xmobarColor "#00ff00" "" . shorten 256
        , ppSort    = getSortByXineramaRule
        }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
--myStartupHook = setWMName "LG3D"
--myStartupHook = ewmhDesktopsStartup >> setWMName "LG3D"
myStartupHook :: X ()
myStartupHook = do
    ewmhDesktopsStartup
    setWMName "LG3D"
    screenSizes <- myScreenSizes
    spawn $
        "ps -A -w -w --no-header -o pid,command=WIDE-COMMAND-COLUMN"
        ++ " | grep '[/]scripts/local/status.sh '\"$DISPLAY\"'$'"
        ++ " | awk '{print $1}' | xargs kill"
        ++ " ; " ++ myDzenCommandLine (head screenSizes)

------------------------------------------------------------------------
-- Status bars
myScreenSizes :: X [Rectangle]
myScreenSizes = liftIO $ openDisplay "" >>= getScreenInfo
myDzenCommandLine :: Rectangle -> String
myDzenCommandLine rect =
    "~/scripts/local/status.sh \"$DISPLAY\""
    ++ " | dzen2 -fn 'VLGothic-10:Bold' -h " ++ show height ++" -ta r -y " ++ show (rect_height rect - height) ++ " -e 'button3=exec:'"
    where height = 16

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
--main = xmonad defaults
--main = xmonad =<< xmobar defaults
--main = xmonad =<< dzen defaults
main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad =<< statusBar
        "xmobar"
        myXmobarPP
        myToggleStrutsKey
        defaults
        { logHook = dynamicLogWithPP myXmobarPP {
              ppOutput = hPutStrLn xmproc
          }
        }

------------------------------------------------------------------------
-- pretty print

------------------------------------------------------------------------


------------------------------------------------------------------------
-- warn before quitting xmonad
--
exitWithConfirm :: ExitCode -> X ()
exitWithConfirm s = withConfirm "quit Xmonad?" $ io (exitWith s)

withConfirm :: String -> X () -> X ()
--withConfirm msg f = whenX (confirm_dmenu msg) f
withConfirm = whenX . confirm_dmenu

confirm_dmenu :: String -> X Bool
confirm_dmenu msg = isStringYes `liftM` dmenu [msg, "y", "n"]
    -- Note that return value of function 'dmenu' have \n as last character.
    where isStringYes = (`elem` yess) . map toLower . filter (/= '\n')
          yess = ["y", "yes"]

------------------------------------------------------------------------
-- utilities
spawnStdout :: MonadIO m => String -> String -> m ()
spawnStdout prog input = liftIO $ spawnPipe prog >>= (\h -> hPutStrLn h input >> hClose h)

messageBox :: MonadIO m => String -> String -> m ()
messageBox title msg = spawnStdout cmd msg
    where cmd = "xmessage -file - -default okay"
    --where cmd = "zenity --text-info --title=" ++ escapeShellArg title

escapeShellArg :: String -> String
escapeShellArg src = "\"" ++ (escape src) ++ "\""
    where escape = foldr escapeChar ""
          escapeChar x = case x of
            '\\' -> ("\\\\" ++)
            '"'  -> ("\\\"" ++)
            x    -> (x :)

mltermTmuxSession :: String -> X ()
mltermTmuxSession s = spawn $ "mlterm -e sh -c " ++ (escapeShellArg $ "tmux -2 attach-session -t " ++ name ++ " || tmux -2 new-session -s " ++ name)
    where name = escapeShellArg s

-- Get pairs of session name with hostname and simple session name.
tmuxSessionsList :: MonadIO m => m [String]
tmuxSessionsList = lines `liftM` runProcessWithInput "tmux" ["list-sessions", "-F", "#S"] ""

mltermAttachTmuxSession :: X ()
mltermAttachTmuxSession = map genAction `liftM` tmuxSessionsList >>= runSelectedAction defaultGSConfig
    where genAction sname = (sname, mltermTmuxSession sname)

tmuxSessionPrompt :: X ()
tmuxSessionPrompt =
    tmuxSessionsList >>=
    (\ss -> inputPromptWithCompl myXPConfig "tmux session" (mkComplFunFromList' ss)
            ?+ mltermTmuxSession)
------------------------------------------------------------------------


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = ewmh $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    --"mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    --"mod-Tab        Move focus to the next window",
    --"mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
