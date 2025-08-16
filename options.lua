local state = require 'lib.state'
local Moan = require('lib.moan')
local controls = require('controls')

return function()
    local awaiting

    local function mainMenu()
        local opts = {
            {"Rebind Up ("..controls.get('up')..")", function() awaiting='up'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Down ("..controls.get('down')..")", function() awaiting='down'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Left ("..controls.get('left')..")", function() awaiting='left'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Right ("..controls.get('right')..")", function() awaiting='right'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Turn Left ("..controls.get('turnLeft')..")", function() awaiting='turnLeft'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Turn Right ("..controls.get('turnRight')..")", function() awaiting='turnRight'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Rebind Action ("..controls.get('action')..")", function() awaiting='action'; Moan.clearMessages(); Moan.speak('Options', {'Press new key'}, {oncomplete=mainMenu}) end},
            {"Back", function() state.switch('title') end}
        }
        Moan.speak('Options', {''}, {options=opts})
    end

    function love.keypressed(key)
        if awaiting then
            controls.set(awaiting, key)
            awaiting = nil
            Moan.clearMessages()
            mainMenu()
        else
            Moan.keypressed(key)
        end
    end

    function love.keyreleased(key)
        Moan.keyreleased(key)
    end

    function love.draw()
        Moan.draw()
    end

    function love.update(dt)
        Moan.update(dt)
    end

    mainMenu()
end
