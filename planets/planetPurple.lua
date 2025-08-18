local state = require 'lib.state'
local scene = require('planets.planet_scene')

return scene({
    avatar = 'assets/avatars/planetPurpleAvatar.png',
    intro = {
        {lines = {"Hello Purple World!"}}
    },
    dialogue = {
        [1] = {
            {before=function() setShipQuest(2) end,
             lines={"Our planet is in great peril...our sisters on PLANET P!NK might be able to help, but we can't get too close because they're made of purple anti-matter.."}},
            {lines={"Can you...--SAVE US?"}, oncomplete=function() state.switch('game') end}
        },
        [2] = {
            {lines={"Maybe PLANET P!NK holds the key."}, oncomplete=function() state.switch('game') end}
        },
        [3] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [4] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [5] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [6] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [7] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [8] = {
            {lines={"We await your return, traveler."}, oncomplete=function() state.switch('game') end}
        },
        [9] = {
            {lines={"You saved us!  Thank you."}, oncomplete=function() state.switch('game') end}
        }
    }
})
