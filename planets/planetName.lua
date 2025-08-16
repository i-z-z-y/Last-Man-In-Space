local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/avatars/nif.png")
  Moan.speak(planets[XY]["name"], {"Hello World!"},  {image=avatar})

  if shipQUEST == 0 then
  elseif shipQUEST == 1 then
  elseif shipQUEST == 2 then
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
    local sx = love.graphics.getWidth() / imgBackGround:getWidth()
    local sy = love.graphics.getHeight() / imgBackGround:getHeight()
    love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)
    Moan.draw()
  end

  function love.keyreleased(key)
    Moan.keyreleased(key)
    if key == "escape" then
       Moan.clearMessages()
       state.switch("main")
     end
  end
end
