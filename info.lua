local state = require "lib.switch"
local x=tonumber(passvar[1])
local y=tonumber(passvar[2])
local distance=tonumber(passvar[3])


local imgBackGround = love.graphics.newImage("assets/maps/mars.jpg")

function love.load()
  state.clear()
end

function love.draw()
  --Set Background iMAGE and calculate resize to fit the whole window resolution
  sx = love.graphics.getWidth() / imgBackGround:getWidth()
  sy = love.graphics.getHeight() / imgBackGround:getHeight()
  love.graphics.draw(imgBackGround, 0, 0, 0, sx, sy)

  love.graphics.print("THE PLANET:  " .. passvar[4] .. "  @  X:  " .. x .. "  Y:  " .. y .. "  DiSTANCE:  " .. distance)
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end

  if love.keyboard.isDown("0") then
    state.switch("main")
  end
end
