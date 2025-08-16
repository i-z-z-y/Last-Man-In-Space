local state = require "lib.state"
local assets = require("assets")

return function(XY)
  XY = tostring(XY)
  local imgBackGround = planets[XY]["imgPS"]
  local avatar = assets.image("assets/sprites/OJeeAvatar2.png")
  Moan.setSpeed(0.01)

  local function sectorOption(x, y)
    local XY = "X" .. x .. "Y" .. y
    local planet = planets[XY]
    local label
    if planet then
      label = string.format("%s - [SECTOR] ( %d, %d )", planet.name, planet.x/100, planet.y/100)
      if planet.visited then
        label = label .. " [VISITED]"
      end
    else
      label = string.format("[SECTOR] ( %d, %d )", x/100, y/100)
    end
    return {label, function() camera.x = x; camera.y = y end}
  end

  local options={
               sectorOption(5000, 5000),
               sectorOption(5000, 95000),
               sectorOption(95000, 5000),
               sectorOption(95000, 95000),
               sectorOption(55555, 55555)
        }
    Moan.speak(
      {"O J E E", {255,69,0}},
      {"HiBBiDDi--BOBiDDi--BOO!","CHOOSE WiSELY--YOU!"},
      {
        x=10,
        y=10,
        options=options,
        image=avatar,
        onstart=function() Moan.setSpeed(0.1) end,
        oncomplete=function() state.switch("main") end,
      })

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
     if key == "0" then
       Moan.clearMessages()
       state.switch("main")
     end
     if key == "escape" then
        Moan.clearMessages()
        state.switch("main")
      end
  end
end
