local XY=tostring(passvar[1])
local imgBackGround = planets[XY]["imgPS"]
state.clear()

local avatar = love.graphics.newImage("assets/avatars/planetGreenAvatar.png")
Moan.speak(planets[XY]["name"], {"Hello Green World!"},  {image=avatar})

if shipQUEST == 0 then
  shipQUEST = 1

  Moan.speak(planets[XY]["name"], {"Our planet is in great peril..." ..
    "our sisters on PLANET PURPLE might be able to help, but we can't get too close because they're made of green anti-matter..."},  {image=avatar})
  Moan.speak(planets[XY]["name"], {"Can you...--SAVE US?"},  {image=avatar, oncomplete=function() state.switch("main") end})
elseif shipQUEST == 1 then
elseif shipQUEST == 2 then
elseif shipQUEST == 3 then
elseif shipQUEST == 4 then
elseif shipQUEST == 5 then
elseif shipQUEST == 6 then
  shipQUEST = 7
  Moan.speak(planets[XY]["name"], {"We heard you are searching for someone on your old home planet...--" ..
    "You'll need to transmit a secret signal...--We're uploading it to your ship now..--It should help you find your friend on PLANET ANDROS."},  {image=avatar})
  Moan.speak(planets[XY]["name"], {"PLEASE, HURRY!"},  {image=avatar, oncomplete=function() state.switch("main") end})
elseif shipQUEST == 7 then
elseif shipQUEST == 8 then
elseif shipQUEST == 9 then
  Moan.speak(planets[XY]["name"], {"That's it!  OUR PLANET is SAFE NOW!  Please, land your ship and join us.  We have prepared a feast in your honor! ;-)"},
  {image=avatar})
  Moan.speak(planets[XY]["name"], {"GAME--OVER"},
  {image=avatar, oncomplete=function() love.event.quit() end})
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
