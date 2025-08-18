local state = require 'lib.state'
local scene = require('planets.planet_scene')

return scene({
    avatar = 'assets/avatars/planetGreenAvatar.png',
    intro = {
        {lines = {"Hello Green World!"}}
    },
    dialogue = {
        [0] = {
            {before=function() setShipQuest(1) end,
             lines={[=[Our planet is in great peril... our sisters on PLANET PURPLE might be able to help, but we can't get too close because they're made of green anti-matter..]=]}},
            {lines={"Can you...--SAVE US?"}, oncomplete=function() state.switch('game') end}
        },
        [6] = {
            {before=function() setShipQuest(7) end,
             lines={"We heard you are searching for someone on your old home planet...--You'll need to transmit a secret signal...--We're uploading it to your ship now..--It should help you find your friend on PLANET ANDROS."}},
            {lines={"PLEASE, HURRY!"}, oncomplete=function() state.switch('game') end}
        },
        [9] = {
            {lines={"That's it!  OUR PLANET is SAFE NOW!  Please, land your ship and join us.  We have prepared a feast in your honor! ;-)"}},
            {lines={"GAME--OVER"}, oncomplete=function() love.event.quit() end}
        }
    }
})
