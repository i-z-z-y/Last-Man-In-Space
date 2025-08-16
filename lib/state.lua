local state = {}

function state.switch(name, ...)
    package.loaded[name] = nil
    local chunk = require(name)
    if type(chunk) == "function" then
        chunk(...)
    end
end

return state
