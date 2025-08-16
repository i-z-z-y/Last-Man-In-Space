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

return assets
