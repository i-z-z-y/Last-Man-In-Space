local state = require 'lib.state'
local scene = require('planets.planet_scene')
local assets = require('assets')

return scene({
    avatar = 'assets/avatars/nif.png',
    dialogue = {
        [0] = {
            {lines={"The place of our birth... and where it all fell...  Our planet is almost dead now...  It took everything we had to build this last ship and escape our now barren planet...  The sacred scrolls fortold of a special place where we can live on in peace and happiness...  Let's find PLANET GREEN!"}, oncomplete=function() state.switch('game') end}
        },
        [3] = {
            {before=function() shipQUEST = 4 end,
             lines={"There's nothing here...There's no one here..."}},
            {lines={"WHAT NOW?"}, oncomplete=function() state.switch('game') end}
        },
        [4] = {
            {before=function() shipQUEST = 5 end,
             lines={"There's still nothing here...There's no one here..."}},
            {lines={"WHAT MORE CAN BE DONE?"}, oncomplete=function() state.switch('game') end}
        },
        [5] = {
            {before=function() shipQUEST = 6 end,
             lines={"There's really nothing here...Let's check back at PLANET GREEN and see if there's a clue..."}},
            {lines={"WHAT MORE CAN BE DONE?"}, oncomplete=function() state.switch('game') end}
        },
        [7] = {
            {before=function(planet) shipQUEST = 8; avatar = assets.image('assets/avatars/planetAndrosAvatar.png') end,
             lines={"Don't...--don't worry about me...--I'm done for...--What you're looking for is in sector--55, ..."}},
            {before=function(planet) planet.live = false; avatar = assets.image('assets/avatars/nif.png') end,
             lines={"The planet...--it's...EXPLODED!"}, oncomplete=function() state.switch('game') end}
        }
    }
})
