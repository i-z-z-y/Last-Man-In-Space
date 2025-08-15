local imgBackGround = love.graphics.newImage('assets/maps/quit.png')

options={
               {"NO",  function() state.switch("main") end},
               {"YES",  function() love.event.quit() end},
        }
Moan.speak({"E X ! T", {255,69,0}},{"QUiT?"},{x=10, y=10, options=options,
oncomplete=function() state.switch("main") end,})

local avatar = love.graphics.newImage("assets/avatars/nif.png")




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
end
