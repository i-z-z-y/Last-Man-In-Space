local state = require "lib.state"

return function()
    local options = {"Start", "Quit"}
    local index = 1

    function love.keypressed(key)
        if key == "up" or key == "w" then
            index = index - 1
            if index < 1 then index = #options end
        elseif key == "down" or key == "s" then
            index = index + 1
            if index > #options then index = 1 end
        elseif key == "return" or key == "space" then
            if index == 1 then
                state.switch("game")
            else
                love.event.quit()
            end
        end
    end

    function love.draw()
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        love.graphics.printf("Last Man In Space", 0, h/3, w, "center")
        love.graphics.printf("Use W/S or Up/Down to choose", 0, h/3 + 30, w, "center")
        for i, option in ipairs(options) do
            local prefix = (i == index) and "> " or "  "
            love.graphics.printf(prefix .. option, 0, h/2 + (i-1)*20, w, "center")
        end
    end

    function love.update(dt) end
end
