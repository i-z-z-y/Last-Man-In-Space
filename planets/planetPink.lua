local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/avatars/planetPinkAvatar.png")
  Moan.speak(planets[XY]["name"], {"Hello P!nk World!"},  {image=avatar})

  if shipQUEST == 0 then
    Moan.speak(planets[XY]["name"], {"You can find PLANET GREEN in SECTOR 555,555"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 1 then
    Moan.speak(planets[XY]["name"], {"Maybe PLANET PURPLE knows how to help us."}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 2 then
    shipQUEST = 3
    Moan.speak(planets[XY]["name"], {"Our planet is in great peril..." ..
      "you'll find an old friend on your old home PLANET ANDROS that might be able to help..."},  {image=avatar})
    Moan.speak(planets[XY]["name"], {"Can you...--SAVE US?"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 3 then
    Moan.speak(planets[XY]["name"], {"Did the traveler on PLANET ANDROS give you clues?"}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 4 or shipQUEST == 5 or shipQUEST == 6 or shipQUEST == 7 or shipQUEST == 8 then
    Moan.speak(planets[XY]["name"], {"We're holding on... please hurry!"}, {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 9 then
    Moan.speak(planets[XY]["name"], {"Thank you!  Our skies are bright once more."}, {image=avatar, oncomplete=function() state.switch("game") end})
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
