local state = require 'lib.state'
local scene = require('planets.planet_scene')

return scene({
    avatar = 'assets/avatars/planetPinkAvatar.png',
    intro = {
        {lines = {"Hello P!nk World!"}}
    },
    dialogue = {
        [0] = {
            {lines={"You can find PLANET GREEN in SECTOR 555,555"}, oncomplete=function() state.switch('game') end}
        },
        [1] = {
            {lines={"Maybe PLANET PURPLE knows how to help us."}, oncomplete=function() state.switch('game') end}
        },
        [2] = {
            {before=function() shipQUEST = 3 end,
             lines={"Our planet is in great peril...you'll find an old friend on your old home PLANET ANDROS that might be able to help..."}},
            {lines={"Can you...--SAVE US?"}, oncomplete=function() state.switch('game') end}
        },
        [3] = {
            {lines={"Did the traveler on PLANET ANDROS give you clues?"}, oncomplete=function() state.switch('game') end}
        },
        [4] = {
            {lines={"We're holding on... please hurry!"}, oncomplete=function() state.switch('game') end}
        },
        [5] = {
            {lines={"We're holding on... please hurry!"}, oncomplete=function() state.switch('game') end}
        },
        [6] = {
            {lines={"We're holding on... please hurry!"}, oncomplete=function() state.switch('game') end}
        },
        [7] = {
            {lines={"We're holding on... please hurry!"}, oncomplete=function() state.switch('game') end}
        },
        [8] = {
            {lines={"We're holding on... please hurry!"}, oncomplete=function() state.switch('game') end}
        },
        [9] = {
            {lines={"Thank you!  Our skies are bright once more."}, oncomplete=function() state.switch('game') end}
        }
    }
})
