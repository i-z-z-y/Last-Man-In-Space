local state = require "lib.state"
local assets = require "assets"
local config = require "config"

return function()
    local options = {"Start", "Options", "Quit"}
    local index = 1
    local bg = assets.image("assets/maps/spacey.jpg")
    local music = love.audio.newSource("assets/music.ogg", "stream")
    music:setLooping(true)
    music:setVolume(0.11)
    music:play()

    local function stopMusic()
        if music then
            music:stop()
            music:release()
            music = nil
        end
    end

    function love.keypressed(key)
        if key == "up" or key == "w" then
            index = index - 1
            if index < 1 then index = #options end
        elseif key == "down" or key == "s" then
            index = index + 1
            if index > #options then index = 1 end
        elseif key == "return" or key == "space" then
            stopMusic()
            if index == 1 then
                state.switch("game")
            elseif index == 2 then
                state.switch("options")
            else
                love.event.quit()
            end
        end
    end

    function love.draw()
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        local sx = w / bg:getWidth()
        local sy = h / bg:getHeight()
        love.graphics.draw(bg, 0, 0, 0, sx, sy)
        love.graphics.printf("Last Man In Space", 0, h/3, w, "center")
        love.graphics.printf("Use W/S or Up/Down to choose", 0, h/3 + 30, w, "center")
        for i, option in ipairs(options) do
            local prefix = (i == index) and "> " or "  "
            love.graphics.printf(prefix .. option, 0, h/2 + (i-1)*20, w, "center")
        end
        love.graphics.printf("Version " .. config.VERSION, 0, h - 20, w, "center")
    end

    function love.update(dt) end

    function love.quit()
        stopMusic()
    end
end
