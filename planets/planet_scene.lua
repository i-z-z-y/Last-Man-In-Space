local state = require 'lib.state'
local Moan = require('lib.moan')
local assets = require('assets')
local planets = require('planets.data.planets')

--[[
`config` table fields:
  avatar   – path to an image shown next to dialogue
  intro    – array of dialogue entry tables run on first visit
  dialogue – table keyed by `shipQUEST` stage with arrays of entries

Each dialogue entry may contain:
  lines       – array of strings displayed by Moan
  before(p)   – optional callback executed before the lines are shown
  oncomplete  – optional callback after the entry finishes
]]

return function(config)
    return function(XY)
        XY = tostring(XY)
        local planet = planets[XY]
        local imgBackGround = planet.imgPS
        local avatar = assets.image(config.avatar)

        local function runEntries(entries)
            if entries then
                for _, entry in ipairs(entries) do
                    if entry.before then entry.before(planet) end
                    local opts = {image=avatar}
                    if entry.oncomplete then opts.oncomplete = entry.oncomplete end
                    Moan.speak(planet.name, entry.lines, opts)
                end
            end
        end

        runEntries(config.intro)
        runEntries(config.dialogue and config.dialogue[shipQUEST])

        function love.update(dt) Moan.update(dt) end
        function love.draw()
            local sx = love.graphics.getWidth() / imgBackGround:getWidth()
            local sy = love.graphics.getHeight() / imgBackGround:getHeight()
            love.graphics.draw(imgBackGround,0,0,0,sx,sy)
            love.graphics.print("Press ESCAPE to go back...")
            Moan.draw()
        end
        function love.keyreleased(key)
            Moan.keyreleased(key)
            if key == 'escape' then
                Moan.clearMessages()
                state.switch('game')
            end
        end
    end
end
