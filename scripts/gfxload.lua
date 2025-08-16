local assets = require("assets")
local anim8 = require("lib.anim8")
local PM7 = require("lib.playmat")

local M = {}

function M.load()
    -- images
    local imgPLANE7 = assets.image("assets/maps/stars10000.png")
    local imgBG = assets.image("assets/maps/spacey.jpg")
    local spriteimg = assets.image("assets/sprites/yeehaw.png")
    local imgCOMPASS = assets.image("assets/sprites/imgCOMPASS.png")

    -- ship animations
    local imgSHIP0 = assets.image("assets/sprites/ship0.png")
    local gridSHIP0 = anim8.newGrid(400, 400, imgSHIP0:getWidth(), imgSHIP0:getHeight())
    local aniSHIP0 = anim8.newAnimation(gridSHIP0('1-8',1), 0.2)

    local imgSHIP1 = assets.image("assets/sprites/ship1.png")
    local gridSHIP1 = anim8.newGrid(400, 400, imgSHIP1:getWidth(), imgSHIP1:getHeight())
    local aniSHIP1 = anim8.newAnimation(gridSHIP1('1-4',1), 0.2)

    local function setupCamera()
        local camera = PM7.newCamera(love.graphics.getWidth(), love.graphics.getHeight())
        camera:setZoom(100)
        camera:setFov(2)
        camera:setOffset(0.333)
        return camera
    end

    return {
        images = {
            imgPLANE7 = imgPLANE7,
            imgBG = imgBG,
            spriteimg = spriteimg,
            imgCOMPASS = imgCOMPASS,
            imgSHIP0 = imgSHIP0,
            imgSHIP1 = imgSHIP1
        },
        animations = {
            aniSHIP0 = aniSHIP0,
            aniSHIP1 = aniSHIP1
        },
        setupCamera = setupCamera
    }
end

return M
