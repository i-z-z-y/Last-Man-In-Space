local state = require "lib.state"
local assets = require("assets")

return function(x, y, distance, name)
  local imgBackGround = assets.image("assets/maps/mars.jpg")

  function love.draw()
    local sx = love.graphics.getWidth() / imgBackGround:getWidth()
    local sy = love.graphics.getHeight() / imgBackGround:getHeight()
    love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)
    love.graphics.print("THE PLANET:  " .. name .. "  @  X:  " .. x .. "  Y:  " .. y .. "  DiSTANCE:  " .. distance)
  end

  function love.update(dt)
    if love.keyboard.isDown("escape") then
      love.event.quit()
    end
    if love.keyboard.isDown("0") then
      state.switch("game")
    end
  end
end
