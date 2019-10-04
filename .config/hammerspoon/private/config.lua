--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Specify Spoons which will be loaded
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hspoon_list = {
    -- "Asana",
    -- "BingDaily",
    -- "BrewInfo",
    -- "Caffeine",
    -- "Calendar",
    -- "CircleClock",
    -- "ClipboardTool",
    -- "ClipShow",
    -- "ColorPicker",
    -- "Commander",
    -- "CountDown",
    -- "DeepLTranslate",
    -- "Emojis",
    -- "EvernoteOpenAndTag",
    -- "FadeLogo",
    -- "FnMate",
    -- "HCalendar",
    -- "HeadphoneAutoPause",
    -- "HighSierraiTunesMediaFix",
    -- "HoldToQuit",
    "HSaria2",
    -- "HSearch",
    "HSKeybindings",
    -- "Keychain",
    "KSheet",
    -- "Leanpub",
    -- "LookupSelection",
    -- "MenubarFlag",
    -- "MicMute",
    -- "MiroWindowsManager",
    "ModalMgr",
    -- "MountedVolumes",
    -- "MouseCircle",
    -- "MoveSpaces",
    -- "PasswordGenerator",
    -- "Pastebin",
    -- "PersonalHotspot",
    -- "PopupTranslateSelection",
    -- "RecursiveBinder",
    -- "ReloadConfiguration",
    -- "RoundedCorners",
    -- "Seal",
    -- "SendToOmniFocus",
    -- "Shade",
    -- "SleepCorners",
    -- "SpeedMenu",
    -- "SpoonInstall",
    -- "TextClipboardHistory",
    -- "TimeFlow",
    -- "TimeMachineProgress",
    -- "ToggleScreenRotation",
    -- "ToggleSkypeMute",
    -- "Token",
    -- "Tunnelblick",
    -- "UniversalArchive",
    -- "UnsplashZ",
    -- "URLDispatcher",
    -- "USBDeviceActions",
    -- "VolumeScroll",
    -- "WifiNotifier",
    -- "WiFiTransitions",
    -- "WindowGrid",
    -- "WindowHalfsAndThirds",
    -- "WindowScreenLeftAndRight",
    -- "WinWin"
}


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- appM environment keybindings. Bundle `id` is prefered, but application `name` will be ok.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsapp_list = {
    --{key = 'a', name = 'Atom'},
    {key = 'a', id = 'com.apple.ActivityMonitor'},
    {key = 'c', name = 'Google Chrome'},
    --{key = 'd', name = 'ShadowsocksX'},
    --{key = 'e', name = 'Emacs'},
    {key = 'f', name = 'Finder'},
    {key = 'i', name = 'iTerm'},
    --{key = 'k', name = 'KeyCastr'},
    {key = 'l', name = 'Slack'},
    --{key = 'm', name = 'MacVim'},
    {key = 'm', name = 'Firefox'},
    --{key = 'p', name = 'mpv'},
    {key = 'p', name = 'Spotify'},
    --{key = 'r', name = 'VimR'},
    {key = 's', name = 'Safari'},
    {key = 't', name = 'Terminal'},
    {key = 'u', name = 'Sketch'},
    {key = 'v', name = 'Visual Studio Code - Insiders'},
    --{key = 'w', name = 'Mweb'},
    {key = 'y', id = 'com.apple.systempreferences'},
}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Modal supervisor keybinding, which can be used to temporarily disable ALL modal environments.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsupervisor_keys = {{"cmd", "shift", "ctrl"}, "Q"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Reload Hammerspoon configuration
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsreload_keys = {{"cmd", "shift", "ctrl"}, "R"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle help panel of this configuration.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hshelp_keys = {{"alt", "shift"}, "/"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- aria2 RPC host address
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsaria2_host = "http://localhost:6800/jsonrpc"

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- aria2 RPC host secret
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsaria2_secret = "token"

--
-- Those keybindings below could be disabled by setting to {"", ""} or {{}, ""}
--

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Window hints keybinding: Focuse to any window you want
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hswhints_keys = {"alt", "tab"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- appM environment keybinding: Application Launcher
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsappM_keys = {"alt", "A"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- clipshowM environment keybinding: System clipboard reader
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hsclipsM_keys = {"alt", "C"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle the display of aria2 frontend
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hsaria2_keys = {"alt", "D"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Launch Hammerspoon Search
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsearch_keys = {"alt", "G"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Read Hammerspoon and Spoons API manual in default browser
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsman_keys = {"alt", "H"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- countdownM environment keybinding: Visual countdown
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hscountdM_keys = {"alt", "I"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Lock computer's screen
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hslock_keys = {"alt", "L"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- resizeM environment keybinding: Windows manipulation
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsresizeM_keys = {"alt", "R"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- cheatsheetM environment keybinding: Cheatsheet copycat
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hscheats_keys = {"alt", "S"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Show digital clock above all windows
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsaclock_keys = {"alt", "T"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Type the URL and title of the frontmost web page open in Google Chrome or Safari.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hstype_keys = {"alt", "V"}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle Hammerspoon console
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsconsole_keys = {"alt", "Z"}
