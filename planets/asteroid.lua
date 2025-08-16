local state = require 'lib.state'
local scene = require('planets.planet_scene')

return scene({
    avatar = 'assets/avatars/nif.png',
    intro = {
        {lines={". . .--it's an asteroid."}}
    },
    dialogue = {
        [8] = {
            {before=function(planet) shipQUEST = 9; planet.live = false end,
             lines={"There's something here...--I think we can save PLANET GREEN...--we'll have to destroy the asteroid, but it might work.  Let's go to PLANET GREEN!"},
             oncomplete=function() state.switch('game') end}
        }
    }
})
