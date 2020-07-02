-- Global log level. Per-spoon log level can be configured in each Install:andUse block below.
hs.logger.defaultLogLevel="info"

hs.hotkey.alertDuration = 0
hs.window.animationDuration = 0
hs.hints.showTitleThresh = 0

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- CONFIGURATION
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Use The Standardized Config Location, If Present.
--
custom_config = hs.fs.pathToAbsolute(os.getenv('HOME') .. '/.config/hammerspoon/private/config.lua')
if custom_config then
    print('Loading Custom Config')
    dofile( os.getenv('HOME') .. '/.config/hammerspoon/private/config.lua')
    privatepath = hs.fs.pathToAbsolute(hs.configdir .. '/private/config.lua')
    if privatepath then
        -- hs.notify.new({
        --   title='Great Success!',
        --   informativeText='Configuration was successfully loaded.',
        --   contentImage="~/Pictures/GIF's/Giphy/DeezNuts.gif",
        --   soundName='HA! Gotemmm'
        -- }):send()
        hs.alert('                      Multiple config files found:\n    ~/hammerspoon  &  ~/.hammerspoon/private\n      The `~/hammerspoon` one will be used.')
    end
else
    -- otherwise fallback to 'classic' location.
    if not privatepath then
        privatepath = hs.fs.pathToAbsolute(hs.configdir .. '/private')
        -- Create `~/.hammerspoon/private` directory if not exists.
        hs.fs.mkdir(hs.configdir .. '/private')
    end
    privateconf = hs.fs.pathToAbsolute(hs.configdir .. '/private/config.lua')
    if privateconf then
        -- Load awesomeconfig file if exists
        require('private/config')
    end
end

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- CONFIGURATION RELOADING
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- DEFAULT CONFIG RELOADING
--
-- hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'R', function()
--   hs.reload()
-- end)
-- hs.alert.show('Config Loaded!')

--
-- FANCY CONFIG RELOADING
--
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/hammerspoon/', reloadConfig):start()
hs.alert.show('Config Loaded!')

-- SMART CONFIGURATION RELOADING WITH SPOONS
hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()


hsreload_keys = hsreload_keys or {{"cmd", "shift", "ctrl"}, "R"}
if string.len(hsreload_keys[2]) > 0 then
    hs.hotkey.bind(hsreload_keys[1], hsreload_keys[2], "Reload Configuration", function() hs.reload() end)
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- ModalMgr
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
--
hs.loadSpoon("ModalMgr")

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- DEFAULT SPOONS LIST
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Define default Spoons which will be loaded later.
--
if not hspoon_list then
    hspoon_list = {
        -- "Asana",
        -- "BingDaily",
        -- "BrewInfo",
        -- "Caffeine",
        -- "Calendar",
        -- "CircleClock",
        -- "ClipboardTool",
        "ClipShow",
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
        -- "HSaria2",
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
        "TextClipboardHistory",
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
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- CREATE / REGISTER MODAL KEYBINDINGS ENVIRONMENTS
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Register windowHints (Register a keybinding which is NOT modal environment with modal supervisor)
--
hswhints_keys = hswhints_keys or {"alt", "tab"}
if string.len(hswhints_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hswhints_keys[1], hswhints_keys[2], 'Show Window Hints', function()
        spoon.ModalMgr:deactivateAll()
        hs.hints.windowHints()
    end)
end



--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- appM ENVIRONMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
spoon.ModalMgr:new("appM")
local cmodal = spoon.ModalMgr.modal_list["appM"]
cmodal:bind('', 'escape', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
cmodal:bind('', 'Q', 'Deactivate appM', function() spoon.ModalMgr:deactivate({"appM"}) end)
cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
if not hsapp_list then
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
end
for _, v in ipairs(hsapp_list) do
    if v.id then
        local located_name = hs.application.nameForBundleID(v.id)
        if located_name then
            cmodal:bind('', v.key, located_name, function()
                hs.application.launchOrFocusByBundleID(v.id)
                spoon.ModalMgr:deactivate({"appM"})
            end)
        end
    elseif v.name then
        cmodal:bind('', v.key, v.name, function()
            hs.application.launchOrFocus(v.name)
            spoon.ModalMgr:deactivate({"appM"})
        end)
    end
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -˝ - - -
-- REGISTER KEYBINDINGS FOR MODAL SUPERVISOR
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsappM_keys = hsappM_keys or {"alt", "A"}
if string.len(hsappM_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hsappM_keys[1], hsappM_keys[2], "Enter AppM Environment", function()
        spoon.ModalMgr:deactivateAll()
        -- Show the keybindings cheatsheet once appM is activated
        spoon.ModalMgr:activate({"appM"}, "#FFBD2E", true)
    end)
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- clipshowM MODAL ENVIRONMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
if spoon.ClipShow then
    spoon.ModalMgr:new("clipshowM")
    local cmodal = spoon.ModalMgr.modal_list["clipshowM"]
    cmodal:bind('', 'escape', 'Deactivate clipshowM', function()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'Q', 'Deactivate clipshowM', function()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'N', 'Save this Session', function()
        spoon.ClipShow:saveToSession()
    end)
    cmodal:bind('', 'R', 'Restore last Session', function()
        spoon.ClipShow:restoreLastSession()
    end)
    cmodal:bind('', 'B', 'Open in Browser', function()
        spoon.ClipShow:openInBrowserWithRef()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'S', '[MacVim](https://github.com/macvim-dev) with Bing', function()
        spoon.ClipShow:openInBrowserWithRef("https://www.bing.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    -- cmodal:bind('', 'M', 'Open in MacVim', function()
    --     spoon.ClipShow:openWithCommand("/usr/local/bin/mvim")
    --     spoon.ClipShow:toggleShow()
    --     spoon.ModalMgr:deactivate({"clipshowM"})
    -- end)
    cmodal:bind('', 'F', 'Save to Desktop', function()
        spoon.ClipShow:saveToFile()
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'H', 'Search in Github', function()
        spoon.ClipShow:openInBrowserWithRef("https://github.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'G', 'Search with Google', function()
        spoon.ClipShow:openInBrowserWithRef("https://www.google.com/search?q=")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'L', 'Open in Sublime Text', function()
        spoon.ClipShow:openWithCommand("/usr/local/bin/subl")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)
    cmodal:bind('', 'V', 'Open in Visual Studio Code', function()
        spoon.ClipShow:openWithCommand("/usr/local/bin/code")
        spoon.ClipShow:toggleShow()
        spoon.ModalMgr:deactivate({"clipshowM"})
    end)

    -- Register clipshowM with modal supervisor
    hsclipsM_keys = hsclipsM_keys or {"alt", "C"}
    if string.len(hsclipsM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsclipsM_keys[1], hsclipsM_keys[2], "Enter clipshowM Environment", function()
            -- We need to take action upon hsclipsM_keys is pressed, since pressing another key to showing ClipShow panel is redundant.
            spoon.ClipShow:toggleShow()
            -- Need a little trick here. Since the content type of system clipboard may be "URL", in which case we don't need to activate clipshowM.
            if spoon.ClipShow.canvas:isShowing() then
                spoon.ModalMgr:deactivateAll()
                spoon.ModalMgr:activate({"clipshowM"})
            end
        end)
    end
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- REGISTER HAMMERSPOON API MANUAL
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Open Hammerspoon manual in default browser.
--
hsman_keys = hsman_keys or {"alt", "H"}
if string.len(hsman_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hsman_keys[1], hsman_keys[2], "Read Hammerspoon Manual", function()
        hs.doc.hsdocs.forceExternalBrowser(true)
        hs.doc.hsdocs.moduleEntitiesInSidebar(true)
        hs.doc.hsdocs.help()
    end)
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- REGISTER LOCK SCREEN
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- hslock_keys = hslock_keys or {"alt", "L"}
-- if string.len(hslock_keys[2]) > 0 then
--     spoon.ModalMgr.supervisor:bind(hslock_keys[1], hslock_keys[2], "Lock Screen", function()
--         hs.caffeinate.lockScreen()
--     end)
-- end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- cheatsheetM MODAL ENVIRONMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Because KSheet Spoon is NOT loaded, cheatsheetM will NOT be activated.
--
if spoon.KSheet then
    spoon.ModalMgr:new("cheatsheetM")
    local cmodal = spoon.ModalMgr.modal_list["cheatsheetM"]
    cmodal:bind('', 'escape', 'Deactivate cheatsheetM', function()
        spoon.KSheet:hide()
        spoon.ModalMgr:deactivate({"cheatsheetM"})
    end)
    cmodal:bind('', 'Q', 'Deactivate cheatsheetM', function()
        spoon.KSheet:hide()
        spoon.ModalMgr:deactivate({"cheatsheetM"})
    end)

    -- Register cheatsheetM with modal supervisor
    hscheats_keys = hscheats_keys or {"alt", "S"}
    if string.len(hscheats_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hscheats_keys[1], hscheats_keys[2], "Enter cheatsheetM Environment", function()
            spoon.KSheet:show()
            spoon.ModalMgr:deactivateAll()
            spoon.ModalMgr:activate({"cheatsheetM"})
        end)
    end
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- REGISTER BROWSER TAB TYPIST
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Type URL of current tab of running browser in markdown format. i.e. [title](link)
--
hstype_keys = hstype_keys or {"alt", "V"}
if string.len(hstype_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hstype_keys[1], hstype_keys[2], "Type Browser Link", function()
        local safari_running = hs.application.applicationsForBundleID("com.apple.Safari")
        local chrome_running = hs.application.applicationsForBundleID("com.google.Chrome")
        if #safari_running > 0 then
            local stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
            if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
        elseif #chrome_running > 0 then
            local stat, data = hs.applescript('tell application "Google Chrome" to get {URL, title} of active tab of window 1')
            if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
        end
    end)
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- REGISTER HAMMERSPOON CONSOLE
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
hsconsole_keys = hsconsole_keys or {"alt", "Z"}
if string.len(hsconsole_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hsconsole_keys[1], hsconsole_keys[2], "Toggle Hammerspoon Console", function() hs.toggleConsole() end)
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- NOTIFICATIONS
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- DEFAULT NOTIFICATION
-- hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'W', function()
--   hs.alert.show('Hello World!')
-- end)

-- macOS NATIVE NOTIFICATION
hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'W', function()
  hs.notify.new({title='Hammerspoon', informativeText='Hello World'}):send()
end)


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- WINDOW MANAGEMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Something to note is that `hs.screen.frame()` does not include the menubar and
-- dock, see `hs.screen.fullFrame()` if you need that) and set the frame of the
-- window to occupy the left half of the screen.
--
-- SNAP WINDOW LEFT ( 50% )
hs.hotkey.bind({'cmd', 'ctrl'}, 'Left', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- SNAP WINDOW RIGHT ( 50% )
hs.hotkey.bind({'cmd', 'ctrl'}, 'Right', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- SNAP WINDOW 100% ( FULL-WIDTH )
hs.hotkey.bind({'cmd', 'ctrl'}, 'Up', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- SNAP WINDOW 50% ( CENTER )
hs.hotkey.bind({'cmd', 'ctrl'}, 'Down', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 8)
  f.y = max.y + (max.h / 8)
  f.w = max.w * 0.75
  f.h = max.h * 0.75
  win:setFrame(f)
end)

-- MOVE WINDOW 1 SCREEN LEFT ( 50% )
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'Left', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
  win:moveOneScreenWest()
end)

-- MOVE WINDOW 1 SCREEN RIGHT ( 50% )
hs.hotkey.bind({'cmd', 'ctrl', 'shift'}, 'Right', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
  win:moveOneScreenEast()
end)


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- MORE COMPLEX WINDOW MOVEMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- We can build on the simple window movement example to implement a set of
-- keyboard shortcuts that allow us to move a window in all directions, using the
-- nethack movement keys:
--
--     y   k   u
--     h       l
--     b   j   n
--
-- To do this, we simply need to repeat the previous hs.hotkey.bind() call with
-- slightly different frame modifications:
--
-- MOVE WINDOW TOP-LEFT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y - 10
  win:setFrame(f)
end)

-- MOVE WINDOW TOP-CENTER
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

-- MOVE WINDOW TOP-RIGHT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y - 10
  win:setFrame(f)
end)

-- MOVE WINDOW CENTER-LEFT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

-- MOVE WINDOW CENTER-RIGHT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

-- MOVE WINDOW BOTTOM-LEFT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y + 10
  win:setFrame(f)
end)

-- MOVE WINDOW BOTTOM-CENTER
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

-- MOVE WINDOW BOTTOM-RIGHT
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y + 10
  win:setFrame(f)
end)


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- INITIALIZE ModalMgr Supervisor
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
spoon.ModalMgr.supervisor:enter()

