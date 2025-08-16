local state = require "lib.state"
local assets = require("assets")

return function()
  local imgBackGround = assets.image('assets/maps/quit.png')
  local options={
               {"NO",  function() state.switch("game") end},
               {"YES",  function() love.event.quit() end},
        }
  Moan.speak({"E X ! T", {255,69,0}},{"QUiT?"},{x=10, y=10, options=options,oncomplete=function() state.switch("game") end,})
  local avatar = assets.image("assets/avatars/nif.png")

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
  end
end
