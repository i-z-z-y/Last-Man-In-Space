local XY=tostring(passvar[1])
local imgBackGround = planets[XY]["imgPS"]
state.clear()

local avatar = love.graphics.newImage("assets/avatars/planetPinkAvatar.png")
Moan.speak(planets[XY]["name"], {"Hello P!nk World!"},  {image=avatar})


if shipQUEST == 0 then
  Moan.speak(planets[XY]["name"], {"You can find PLANET GREEN in SECTOR 555,555"},  {image=avatar, oncomplete=function() state.switch("main") end})
elseif shipQUEST == 1 then
elseif shipQUEST == 2 then
  shipQUEST = 3
  Moan.speak(planets[XY]["name"], {"Our planet is in great peril..." ..
    "you'll find an old friend on your old home PLANET ANDROS that might be able to help..."},  {image=avatar})
  Moan.speak(planets[XY]["name"], {"Can you...--SAVE US?"},  {image=avatar, oncomplete=function() state.switch("main") end})
elseif shipQUEST == 3 then
elseif shipQUEST == 4 then
elseif shipQUEST == 5 then
elseif shipQUEST == 6 then
elseif shipQUEST == 7 then
elseif shipQUEST == 8 then
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
