local This = {}

-- To easily layout windows on the screen, we use hs.grid to create a 4x4 grid.
-- If you want to use a more detailed grid, simply change its dimension here
local GRID_SIZE = 4
local HALF_GRID_SIZE = GRID_SIZE / 2

-- Set the grid size and add a few pixels of margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({5, 5})
hs.window.animationDuration = 0

-- Defining screen positions
local screenPositions       = {}
screenPositions.left        = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.right       = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.top         = {x = 0,              y = 0,              w = GRID_SIZE,      h = HALF_GRID_SIZE}
screenPositions.bottom      = {x = 0,              y = HALF_GRID_SIZE, w = GRID_SIZE,      h = HALF_GRID_SIZE}

screenPositions.topLeft     = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.topRight    = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomLeft  = {x = 0,              y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomRight = {x = HALF_GRID_SIZE, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}

This.screenPositions = screenPositions

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function This.moveWindowToPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

-- This function will move either the specified or the focused
-- window to the center of the sreen and let it fill up the
-- entire screen.
function This.windowMaximize(factor, window)
   if window == nil then
      window = hs.window.focusedWindow()
   end
   if window then
      window:maximize()
   end
end


--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- MORE COMPLEX WINDOW MOVEMENT
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- We Can Build On The Simple Window Movement Example To Implement A Set Of
-- Keyboard Shortcuts That Allow Us To Move A Window In All Directions, Using The
-- Nethack Movement Keys:
--
--     y   k   u
--     h       l
--     b   j   n
--
-- To Do This, We Simply Need To Repeat The Previous `hs.hotkey.bind()` Call With
-- Slightly Different Frame Modifications:
--

-- Move Window Top-left
-- hs.hotkey.bind(super_hyper, "Y", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   f.y = f.y - 10
--   win:setFrame(f)
-- end)

-- -- Move Window Top-center
-- hs.hotkey.bind(super_hyper, "K", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.y = f.y - 10
--   win:setFrame(f)
-- end)

-- -- Move Window Top-right
-- hs.hotkey.bind(super_hyper, "U", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   f.y = f.y - 10
--   win:setFrame(f)
-- end)

-- -- Move Window Center-left
-- hs.hotkey.bind(super_hyper, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   win:setFrame(f)
-- end)

-- -- Move Window Center-right
-- hs.hotkey.bind(super_hyper, "L", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   win:setFrame(f)
-- end)

-- -- Move Window Bottom-left
-- hs.hotkey.bind(super_hyper, "B", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x - 10
--   f.y = f.y + 10
--   win:setFrame(f)
-- end)

-- -- Move Window Bottom-center
-- hs.hotkey.bind(super_hyper, "J", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.y = f.y + 10
--   win:setFrame(f)
-- end)

-- -- Move Window Bottom-right
-- hs.hotkey.bind(super_hyper, "N", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()

--   f.x = f.x + 10
--   f.y = f.y + 10
--   win:setFrame(f)
-- end)


return This
