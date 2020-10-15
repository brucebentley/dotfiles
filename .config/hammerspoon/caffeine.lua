-- local This = {}

-- This.menuBar = hs.menubar.new()

-- function setCaffeineDisplay(state)
--    if state then
--       This.menuBar:setIcon(os.getenv("HOME") .. "/.hammerspoon-assets/caffeine/active.png")
--    else
--       This.menuBar:setIcon(os.getenv("HOME") .. "/.hammerspoon-assets/caffeine/inactive.png")
--    end
-- end

-- function caffeineClicked()
--    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end

-- function This.set(state)
--    setCaffeineDisplay(hs.caffeinate.set('displayIdle', state))
-- end

-- function This.toggle()
--    setCaffeineDisplay(hs.caffeinate.toggle('displayIdle'))
-- end

-- function This.install()
--    if This.menuBar then
--     This.menuBar:setClickCallback(caffeineClicked)
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
--    end
-- end


-- return This

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "I", function()
  hs.caffeinate.set("displayIdle", true, true)
  hs.caffeinate.set("systemIdle", true, true)
  hs.caffeinate.set("system", true, true)
  hs.alert.show("Preventing Sleep")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "O", function()
  hs.caffeinate.set("displayIdle", false, true)
  hs.caffeinate.set("systemIdle", false, true)
  hs.caffeinate.set("system", false, true)
  hs.alert.show("Allowing Sleep")
end)
