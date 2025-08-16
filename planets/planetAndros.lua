local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/avatars/nif.png")

  if shipQUEST == 0 then
    Moan.speak(planets[XY]["name"], {"The place of our birth... and where it all fell...  Our planet is almost dead now...  " ..
    "It took everything we had to build this last ship and escape our now barren planet...  " ..
    "The sacred scrolls fortold of a special place where we can live on in peace and happiness...  Let's find PLANET GREEN!"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 1 then
  elseif shipQUEST == 2 then
  elseif shipQUEST == 3 then
    shipQUEST = 4
    Moan.speak(planets[XY]["name"], {"There's nothing here..." ..
      "There's no one here..."},  {image=avatar})
    Moan.speak(planets[XY]["name"], {"WHAT NOW?"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 4 then
    shipQUEST = 5
    Moan.speak(planets[XY]["name"], {"There's still nothing here..." ..
      "There's no one here..."},  {image=avatar})
    Moan.speak(planets[XY]["name"], {"WHAT MORE CAN BE DONE?"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 5 then
    shipQUEST = 6
    Moan.speak(planets[XY]["name"], {"There's really nothing here..." ..
      "Let's check back at PLANET GREEN and see if there's a clue..."},  {image=avatar})
    Moan.speak(planets[XY]["name"], {"WHAT MORE CAN BE DONE?"},  {image=avatar, oncomplete=function() state.switch("game") end})
  elseif shipQUEST == 6 then
  elseif shipQUEST == 7 then
    shipQUEST = 8
    avatar = assets.image("assets/avatars/planetAndrosAvatar.png")
    Moan.speak(planets[XY]["name"], {"Don't...--don't worry about me...--I'm done for...--What you're looking for is in sector--55, ..."}, {image=avatar})
    planets[XY]["live"] = false
    avatar = assets.image("assets/avatars/nif.png")
    Moan.speak(planets[XY]["name"], {"The planet...--it's...EXPLODED!"}, {image=avatar, oncomplete=function() state.switch("game") end})
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
