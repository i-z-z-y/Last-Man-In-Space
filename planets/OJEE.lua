--local state = require "lib.switch"
local XY=tostring(passvar[1])
local imgBackGround = planets[XY]["imgPS"]
local avatar = love.graphics.newImage("assets/sprites/OJeeAvatar2.png")
state.clear()
Moan.setSpeed(0.01)

options={
               {"[SECTOR] ( 50, 50 )",  function() camera.x=5000 camera.y=5000 end},
               {"[SECTOR] ( 50, 950 )",  function() camera.x=5000 camera.y=95000 end},
               {"[SECTOR] ( 950, 50 )",  function() camera.x=95000 camera.y=5000 end},
               {"[SECTOR] ( 950, 950 )",  function() camera.x=95000 camera.y=95000 end},
               {"[SECTOR] ( 555, 555 ) -- GREEN HOME SWEET HOME!",  function() camera.x=55555 camera.y=55555 end}
        }
Moan.speak({"O J E E", {255,69,0}},{"HiBBiDDi--BOBiDDi--BOO!","CHOOSE WiSELY--YOU!"},{x=10, y=10, options=options, image=avatar,
onstart=function() Moan.setSpeed(0.1) end, oncomplete=function() state.switch("main") end,})

function love.update(dt)
  Moan.update(dt)
end

function love.draw()
  --Set Background iMAGE and calculate resize to fit the whole window resolution
  sx = love.graphics.getWidth() / imgBackGround:getWidth()
  sy = love.graphics.getHeight() / imgBackGround:getHeight()
  love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)
  Moan.draw()
end

function love.keyreleased(key)
  Moan.keyreleased(key)
   if key == "0" then
     Moan.clearMessages()
     state.switch("main")
   end
   if key == "escape" then
      Moan.clearMessages()
      state.switch("main")
    end
end
