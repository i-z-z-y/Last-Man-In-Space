local PM7 = require('lib.playmat')

local function createTestImage()
    local data = love.image.newImageData(1,1)
    data:setPixel(0,0,1,1,1,1)
    return love.graphics.newImage(data)
end

local function benchmark()
    local cam = PM7.newCamera(800,600)
    local img = createTestImage()

    local before = love.graphics.getStats()
    for i=1,100 do
        PM7.drawPlane(cam, img)
    end
    local afterPlane = love.graphics.getStats()

    for i=1,100 do
        PM7.placeSprite(cam, img, i*10, i*10, 0, 1, 1)
    end
    PM7.renderSprites(cam)
    local afterSprites = love.graphics.getStats()

    print(string.format('texture memory before=%d afterPlane=%d afterSprites=%d',
        before.texturememory, afterPlane.texturememory, afterSprites.texturememory))
end

return { run = benchmark }
