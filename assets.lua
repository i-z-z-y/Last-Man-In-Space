local assets = {
    images = {},
    fonts = {}
}

function assets.image(path)
    local img = assets.images[path]
    if not img then
        img = love.graphics.newImage(path)
        assets.images[path] = img
    end
    return img
end

function assets.font(path, size)
    assets.fonts[path] = assets.fonts[path] or {}
    local bucket = assets.fonts[path]
    if not bucket[size] then
        bucket[size] = love.graphics.newFont(path, size)
    end
    return bucket[size]
end

function assets.clear()
    for k,img in pairs(assets.images) do
        if img.release then img:release() end
        assets.images[k] = nil
    end
    for path,bucket in pairs(assets.fonts) do
        for size,font in pairs(bucket) do
            if font.release then font:release() end
            bucket[size] = nil
        end
        assets.fonts[path] = nil
    end
end

return assets
