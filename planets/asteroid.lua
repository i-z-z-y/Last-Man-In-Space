local XY=tostring(passvar[1])
local imgBackGround = planets[XY]["imgPS"]
state.clear()

local avatar = love.graphics.newImage("assets/avatars/nif.png")
Moan.speak(planets[XY]["name"], {". . .--it's an asteroid."},  {image=avatar})


if shipQUEST == 0 then
elseif shipQUEST == 1 then
elseif shipQUEST == 2 then
elseif shipQUEST == 3 then
elseif shipQUEST == 4 then
elseif shipQUEST == 5 then
elseif shipQUEST == 6 then
elseif shipQUEST == 7 then
elseif shipQUEST == 8 then
  shipQUEST = 9
  planets[XY]["live"] = false
  Moan.speak(planets[XY]["name"], {"There's something here...--I think we can save PLANET GREEN...--we'll have to destroy the asteroid, but it might work.  Let's go to PLANET GREEN!"},
  {image=avatar, oncomplete=function() state.switch("main") end})
elseif shipQUEST == 9 then
end

function love.update(dt)
  Moan.update(dt)
end

function love.draw()
  --Set Background iMAGE and calculate resize to fit the whole window resolution
  sx = love.graphics.getWidth() / imgBackGround:getWidth()
  sy = love.graphics.getHeight() / imgBackGround:getHeight()
  love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)
  love.graphics.print("Press ESCAPE to go back...")
  Moan.draw()
end

function love.keyreleased(key)
  Moan.keyreleased(key)
  if key == "escape" then
     Moan.clearMessages()
     state.switch("main")
   end
end
