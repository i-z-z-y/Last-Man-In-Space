local json = require('lib.dkjson')

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

local function mergeDefaults()
    for k,v in pairs(defaults) do
        if controls[k] == nil then controls[k] = v end
    end
end

function controls.load()
    local content = love.filesystem.read(fileName)
    if content then
        local data, _, err = json.decode(content)
        if not err and type(data) == 'table' then
            for k,v in pairs(data) do controls[k] = v end
        end
    end
    mergeDefaults()
end

function controls.save()
    local encoded = json.encode(controls.all(), {indent=true})
    love.filesystem.write(fileName, encoded)
end

function controls.get(action)
    return controls[action]
end

--- Set an action to a new key.
-- Returns true on success or false plus conflicting action name.
function controls.set(action, key)
    for k,v in pairs(controls) do
        if k ~= action and v == key then
            return false, k
        end
    end
    controls[action] = key
    controls.save()
    return true
end

function controls.reset()
    for k,v in pairs(defaults) do controls[k] = v end
    controls.save()
end

function controls.all()
    local copy = {}
    for k,v in pairs(controls) do
        if type(v) == 'string' then
            copy[k] = v
        end
    end
    return copy
end

mergeDefaults()

return controls
