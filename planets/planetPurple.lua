local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/avatars/planetPurpleAvatar.png")
  Moan.speak(planets[XY]["name"], {"Hello Purple World!"},  {image=avatar})

  if shipQUEST == 0 then
  elseif shipQUEST == 1 then
    shipQUEST = 2
    Moan.speak(planets[XY]["name"], {"Our planet is in great peril..." ..
      "our sisters on PLANET P!NK might be able to help, but we can't get too close because they're made of purple anti-matter..."},  {image=avatar})
    Moan.speak(planets[XY]["name"], {"Can you...--SAVE US?"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 2 then
    Moan.speak(planets[XY]["name"], {"Maybe PLANET P!NK holds the key."}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 3 or shipQUEST == 4 or shipQUEST == 5 or shipQUEST == 6 or shipQUEST == 7 or shipQUEST == 8 then
    Moan.speak(planets[XY]["name"], {"We await your return, traveler."}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 9 then
    Moan.speak(planets[XY]["name"], {"You saved us!  Thank you."}, {image=avatar, oncomplete=function() state.switch("game") end})
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
