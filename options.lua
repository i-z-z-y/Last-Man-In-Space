local state = require 'lib.state'
local Moan = require('lib.moan')
local controls = require('controls')

return function()
    local awaiting

    local function prompt(action)
        local current = controls.get(action)
        awaiting = action
        Moan.clearMessages()
        Moan.speak('Options', {
            'Press new key for '..action..' (current: '..current..')',
            'Press escape to cancel'
        })
    end

    local function mainMenu()
        local opts = {
            {"Rebind Up ("..controls.get('up')..")", function() prompt('up') end},
            {"Rebind Down ("..controls.get('down')..")", function() prompt('down') end},
            {"Rebind Left ("..controls.get('left')..")", function() prompt('left') end},
            {"Rebind Right ("..controls.get('right')..")", function() prompt('right') end},
            {"Rebind Turn Left ("..controls.get('turnLeft')..")", function() prompt('turnLeft') end},
            {"Rebind Turn Right ("..controls.get('turnRight')..")", function() prompt('turnRight') end},
            {"Rebind Action ("..controls.get('action')..")", function() prompt('action') end},
            {"Reset Defaults", function() controls.reset(); Moan.clearMessages(); mainMenu() end},
            {"Back", function() state.switch('title') end}
        }
        Moan.speak('Options', {''}, {options=opts})
    end

    function love.keypressed(key)
        if awaiting then
            if key == 'escape' then
                awaiting = nil
                Moan.clearMessages()
                mainMenu()
            else
                local ok, conflict = controls.set(awaiting, key)
                awaiting = nil
                Moan.clearMessages()
                if not ok then
                    Moan.speak('Options', {'Key already bound to '..conflict}, {oncomplete=mainMenu})
                else
                    mainMenu()
                end
            end
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
