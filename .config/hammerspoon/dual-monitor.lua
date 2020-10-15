-- - Dual Monitor Hotkeys - --

-- Hotkey Definition - CAPS is mapped to CTRL using karabiner --
hyper = {"ctrl"}
hyper_cmd = {"ctrl", "cmd"}
hyper_shft = {"ctrl", "shift"}


-- - Dual Monitor Functions - --
function toEastMonitor()
    w = hs.window.frontmostWindow()
    w:moveOneScreenEast()
end

function toWestMonitor()
    w = hs.window.frontmostWindow()
    w:moveOneScreenWest()
end

function toNorthMonitor()
    w = hs.window.frontmostWindow()
    w:moveOneScreenNorth()
end

function toSouthMonitor()
    w = hs.window.frontmostWindow()
    w:moveOneScreenSouth()
end


dell_screen = hs.screen.find('DELL P2418D')
if dell_screen then
    x, y = dell_screen:position()
    if x == 0 then
        hs.hotkey.bind(hyper, 'O', toNorthMonitor)
        hs.hotkey.bind(hyper, 'L', toSouthMonitor)

    else
        hs.hotkey.bind(hyper, 'L', toEastMonitor)
        hs.hotkey.bind(hyper, 'K', toWestMonitor)
    end
end

