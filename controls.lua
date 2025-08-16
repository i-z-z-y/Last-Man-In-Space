local defaults = {
    up = 'w',
    down = 's',
    left = 'a',
    right = 'd',
    turnLeft = 'q',
    turnRight = 'e',
    action = 'f'
}

local controls = {}
local fileName = 'controls.conf'

local function serialize(tbl)
    local parts = {'{'}
    local first = true
    for k,v in pairs(tbl) do
        if not first then table.insert(parts, ',') end
        first = false
        table.insert(parts, string.format("[%q]=%q", k, v))
    end
    table.insert(parts, '}')
    return table.concat(parts)
end

function controls.load()
    local chunk = love.filesystem.load(fileName)
    if chunk then
        local ok, data = pcall(chunk)
        if ok and type(data) == 'table' then
            for k,v in pairs(data) do controls[k]=v end
        end
    end
    for k,v in pairs(defaults) do
        if not controls[k] then controls[k] = v end
    end
end

function controls.save()
    love.filesystem.write(fileName, 'return '..serialize(controls))
end

function controls.get(action)
    return controls[action]
end

function controls.set(action, key)
    controls[action] = key
    controls.save()
end

return controls
