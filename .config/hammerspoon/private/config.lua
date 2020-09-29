--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Private Hammerspoon Configuration
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--

-- Hotkey Definition - CAPS is mapped to CTRL using karabiner --
hyper = {'ctrl'}
cmd_hyper = {'cmd', 'ctrl'}
shift_hyper = {'cmd', 'ctrl', 'shift'}
super_hyper = {'cmd', 'ctrl', 'alt'}
alt_hyper = {'alt', 'tab'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Specify Spoons which will be loaded
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hspoon_list = {
    -- 'AClock',
    -- 'AllBrightness',
    -- 'Asana',
    -- 'BingDaily',
    -- 'BonjourLauncher',
    -- 'BrewInfo',
    -- 'Calendar',
    -- 'CircleClock',
    -- 'ClipboardTool',
    -- 'ColorPicker',
    -- 'Commander',
    -- 'CountDown',
    -- 'DeepLTranslate',
    -- 'EjectMenu',
    -- 'Emojis',
    -- 'EvernoteOpenAndTag',
    -- 'FadeLogo',
    -- 'FnMate',
    -- 'HCalendar',
    -- 'HSaria2',
    -- 'HSearch',
    -- 'Hammer',
    -- 'HeadphoneAutoPause',
    -- 'HighSierraiTunesMediaFix',
    -- 'HoldToQuit',
    -- 'Keychain',
    -- 'Leanpub',
    -- 'LookupSelection',
    -- 'MenubarFlag',
    -- 'MicMute',
    -- 'MiroWindowsManager',
    -- 'MountedVolumes',
    -- 'MouseCircle',
    -- 'MoveSpaces',
    -- 'MusicAppMediaFix',
    -- 'PasswordGenerator',
    -- 'Pastebin',
    -- 'PersonalHotspot',
    -- 'PopupTranslateSelection',
    -- 'PushToTalk',
    -- 'RecursiveBinder',
    -- 'ReloadConfiguration',
    -- 'RoundedCorners',
    -- 'Seal',
    -- 'SendToOmniFocus',
    -- 'Shade',
    -- 'SleepCorners',
    -- 'SpeedMenu',
    -- 'TimeFlow',
    -- 'TimeMachineProgress',
    -- 'ToggleScreenRotation',
    -- 'ToggleSkypeMute',
    -- 'Token',
    -- 'Tunnelblick',
    -- 'TurboBoost',
    -- 'URLDispatcher',
    -- 'USBDeviceActions',
    -- 'UniversalArchive',
    -- 'UnsplashRandom',
    -- 'UnsplashZ',
    -- 'VolumeScroll',
    -- 'WiFiTransitions',
    -- 'WifiNotifier',
    -- 'WinWin',
    -- 'WindowGrid',
    -- 'WindowHalfsAndThirds',
    -- 'WindowScreenLeftAndRigh'
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
hsupervisor_keys = {shift_hyper, 'Q'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Reload Hammerspoon configuration
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsreload_keys = {shift_hyper, 'R'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle help panel of this configuration.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hshelp_keys = {alt_hyper, '/'}

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
hswhints_keys = {'alt', 'tab'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- appM environment keybinding: Application Launcher
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsappM_keys = {'alt', 'A'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- clipshowM environment keybinding: System clipboard reader
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hsclipsM_keys = {'alt', 'C'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle the display of aria2 frontend
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hsaria2_keys = {'alt', 'D'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Launch Hammerspoon Search
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsearch_keys = {'alt', 'G'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Read Hammerspoon and Spoons API manual in default browser
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsman_keys = {'alt', 'H'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- countdownM environment keybinding: Visual countdown
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hscountdM_keys = {'alt', 'I'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Lock computer's screen
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hslock_keys = {'alt', 'L'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- resizeM environment keybinding: Windows manipulation
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsresizeM_keys = {'alt', 'R'}[VLC Extensions - addons.videolan.org]

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- cheatsheetM environment keybinding: Cheatsheet copycat
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hscheats_keys = {'alt', 'S'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Show digital clock above all windows
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
--hsaclock_keys = {'alt', 'T'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Type the URL and title of the frontmost web page open in Google Chrome or Safari.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hstype_keys = {'alt', 'V'}

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Toggle Hammerspoon console
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsconsole_keys = {'alt', 'Z'}
