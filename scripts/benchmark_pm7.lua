package.path = package.path .. ';../?.lua;../?/init.lua'

local PM7 = require('lib.playmat')

local function createTestImage()
    local data = love.image.newImageData(1,1)
    data:setPixel(0,0,1,1,1,1)
    return love.graphics.newImage(data)
end

local function runBenchmark(name, renderFn)
    local cam = PM7.newCamera(800,600)
    local img = createTestImage()
    for i=1,100 do
        PM7.placeSprite(cam, img, i*10, i*10, 0, 1, 1)
    end
    local t = love.timer.getTime()
    renderFn(cam)
    local elapsed = love.timer.getTime() - t
    local stats = love.graphics.getStats()
    print(string.format('%s: time=%.6f drawcalls=%d texture=%d', name, elapsed, stats.drawcalls, stats.texturememory))
end

local function benchmark()
    runBenchmark('renderSprites', PM7.renderSprites)
    runBenchmark('renderSpritesBatch', PM7.renderSpritesBatch)
end

if ... == nil then
    function love.load()
        benchmark()
        love.event.quit()
    end
else
    return { run = benchmark }
end
