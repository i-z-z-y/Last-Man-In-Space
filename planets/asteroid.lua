local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/avatars/nif.png")
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
    Moan.speak(planets[XY]["name"], {"There's something here...--I think we can save PLANET GREEN...--we'll have to destroy the asteroid, but it might work.  Let's go to PLANET GREEN!"}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 9 then
  end

  function love.update(dt)
    Moan.update(dt)
  end

  function love.draw()
    local sx = love.graphics.getWidth() / imgBackGround:getWidth()
    local sy = love.graphics.getHeight() / imgBackGround:getHeight()
    love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)
    love.graphics.print("Press ESCAPE to go back...")
    Moan.draw()
  end

  function love.keyreleased(key)
    Moan.keyreleased(key)
    if key == "escape" then
       Moan.clearMessages()
       state.switch("game")
     end
  end
end
