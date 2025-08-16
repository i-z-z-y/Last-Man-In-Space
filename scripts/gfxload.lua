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
    local imgSHIP1 = assets.image("assets/sprites/ship1.png")
    local atlasCanvas = love.graphics.newCanvas(imgSHIP0:getWidth()+imgSHIP1:getWidth(), math.max(imgSHIP0:getHeight(), imgSHIP1:getHeight()))
    love.graphics.setCanvas(atlasCanvas)
    love.graphics.draw(imgSHIP0,0,0)
    love.graphics.draw(imgSHIP1,imgSHIP0:getWidth(),0)
    love.graphics.setCanvas()
    local atlas = love.graphics.newImage(atlasCanvas:newImageData())
    imgSHIP0:release()
    imgSHIP1:release()

    local gridSHIP0 = anim8.newGrid(400, 400, atlas:getWidth(), atlas:getHeight(), 0, 0)
    local gridSHIP1 = anim8.newGrid(400, 400, atlas:getWidth(), atlas:getHeight(), imgSHIP0:getWidth(), 0)
    local aniSHIP0 = anim8.newAnimation(gridSHIP0('1-8',1), 0.2)
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
            imgSHIP0 = atlas,
            imgSHIP1 = atlas
        },
        animations = {
            aniSHIP0 = aniSHIP0,
            aniSHIP1 = aniSHIP1
        },
        setupCamera = setupCamera
    }
end

return M
