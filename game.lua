local state = require "lib.state"
local PM7 = require "lib.playmat"
local anim8 = require 'lib.anim8'
local Moan = require('lib.moan')
local assets = require("assets")
local controls = require('controls')
local json = require('lib.dkjson')

planets = require('planets.data.planets')
-- gameplay constants
local CAMERA_MIN = 4000
local CAMERA_MAX = 96000
local SHIP_SPEED = 300  -- base ship speed
local ANIM_FRAME_TIME = 0.125 -- seconds per frame (8 FPS)
local CAMERA_SMOOTHING = 5 -- camera acceleration factor

local imgPLANE7, imgBG, spriteimg, imgCOMPASS, imgSHIP0, imgSHIP1
local aniSHIP0, aniSHIP1
local camera
local sndBGMain, sndSHIP

shipQUEST = shipQUEST or 0
local shipDirection = 0
local shipROT = 0
local shipOFF = 200
local camVX, camVY = 0, 0 -- camera velocity

local function backupFile(name)
        if love.filesystem.getInfo(name) then
                local data = love.filesystem.read(name)
                if data then love.filesystem.write(name .. '.bak', data) end
        end
end

local function saveProgress()
        if not camera then return end
        local data = { shipQUEST = shipQUEST, camera = {x=camera.x, y=camera.y}, visited = {} }
        for k,v in pairs(planets) do
                if v.visited then data.visited[k] = true end
        end
        backupFile('save.json')
        love.filesystem.write('save.json', json.encode(data, {indent=true}))
end

local function loadProgress()
        local content = love.filesystem.read('save.json')
        if content then
                local data, _, err = json.decode(content)
                if not err and type(data) == 'table' then
                        if type(data.shipQUEST) == 'number' then shipQUEST = data.shipQUEST end
                        if type(data.camera) == 'table' then
                                camera.x = tonumber(data.camera.x) or camera.x
                                camera.y = tonumber(data.camera.y) or camera.y
                        end
                        if type(data.visited) == 'table' then
                                for k,_ in pairs(data.visited) do
                                        if planets[k] then planets[k].visited = true end
                                end
                        end
                end
        end
end

local function setup()
        controls.load()
        love.graphics.setBackgroundColor(0,0,0)
        love.graphics.setDefaultFilter("nearest","nearest")
        Moan.setSpeed(0.1)
        love.mouse.setVisible(false)

        local gfx = require('scripts.gfxload').load()
        imgPLANE7 = gfx.images.imgPLANE7
        imgBG = gfx.images.imgBG
        spriteimg = gfx.images.spriteimg
        imgCOMPASS = gfx.images.imgCOMPASS
        imgSHIP0 = gfx.images.imgSHIP0
        imgSHIP1 = gfx.images.imgSHIP1
        aniSHIP0 = gfx.animations.aniSHIP0
        aniSHIP1 = gfx.animations.aniSHIP1
        camera = gfx.setupCamera()
        camera.x, camera.y = 5000,5000
        loadProgress()
        sndBGMain = love.audio.newSource("assets/music.ogg", "stream")
        sndBGMain:setVolume(0.11)
        sndBGMain:setLooping(true)
        sndBGMain:play()
        sndSHIP = love.audio.newSource("assets/propulsion.wav", "static")
        sndSHIP:setVolume(0.1)
        Moan.font = assets.font("assets/JPfallback.ttf", 32)
        local JPfallback = assets.font("assets/Pixel UniCode.ttf", 32)
        Moan.font:setFallbacks(JPfallback)
        Moan.typeSound = love.audio.newSource("assets/typeSound.wav", "static")
        Moan.optionOnSelectSound = love.audio.newSource("assets/optionSelect.wav", "static")
        Moan.optionSwitchSound = love.audio.newSource("assets/optionSwitch.wav", "static")
        Moan.typeSound:setVolume(0.2)
        Moan.optionOnSelectSound:setVolume(0.2)
        Moan.optionSwitchSound:setVolume(0.2)
        love.audio.setEffect('myEffect', {type = 'reverb'})
        Moan.typeSound:setEffect('myEffect')
        Moan.optionOnSelectSound:setEffect('myEffect')
        Moan.optionSwitchSound:setEffect('myEffect')
        Moan.noImage = assets.image("assets/avatars/nif.png")
        Moan.speak("STAR T", {"W A S D to MOVE... Q E to TURN... F for action... ESCAPE to quit..."})
end

local frame = 0
local framey = 0
local frameX = 0
local frametime = 0

function love.update(dt)
        aniSHIP0:update(dt)  --OUR SHIP
        aniSHIP1:update(dt)  --OUR SHIP

        Moan.update(dt)
        frametime = frametime + dt
        if frametime > ANIM_FRAME_TIME then  --8 FPS --QUAD CODE
          frametime = 0
                --FRAME CODES
                for i,v in pairs(planets) do
                        planets[i]["quadState"] = updateQuadState(planets[i]["quadState"])  --UPDATES QUAD STATE BY RETURNING QUADSTATE AFTER LOGIC PERFORMED
                        planets[i]["quad"]:setViewport(
                                planets[i]["quadWidth"] * planets[i]["quadState"][3],
                                planets[i]["quadHeight"] * planets[i]["quadState"][4],
                                planets[i]["quadWidth"],
                                planets[i]["quadHeight"])
                end
        end
        --  K E Y S  -----------------------------------------------
        local outOfBounds = camera.x < CAMERA_MIN or camera.x > CAMERA_MAX or camera.y < CAMERA_MIN or camera.y > CAMERA_MAX
        local targetVX, targetVY = 0, 0
        if not outOfBounds then
          if love.keyboard.isDown(controls.get('turnLeft')) then
            camera:setRotation(camera:getRotation()-dt)
            shipROT = -0.5
          elseif love.keyboard.isDown(controls.get('turnRight')) then
            camera:setRotation(camera:getRotation()+dt)
            shipROT = 0.5
          end
          if love.keyboard.isDown(controls.get('up')) then
            targetVX = targetVX + math.cos(camera.r)*SHIP_SPEED
            targetVY = targetVY + math.sin(camera.r)*SHIP_SPEED
            shipDirection = 1
            sndSHIP:play()
          elseif love.keyboard.isDown(controls.get('down')) then
            targetVX = targetVX - math.cos(camera.r)*SHIP_SPEED*0.15
            targetVY = targetVY - math.sin(camera.r)*SHIP_SPEED*0.15
          end

          if love.keyboard.isDown(controls.get('left')) then
            targetVX = targetVX + math.cos(camera.r-math.pi/2)*SHIP_SPEED*0.15
            targetVY = targetVY + math.sin(camera.r-math.pi/2)*SHIP_SPEED*0.15
          elseif love.keyboard.isDown(controls.get('right')) then
            targetVX = targetVX + math.cos(camera.r+math.pi/2)*SHIP_SPEED*0.15
            targetVY = targetVY + math.sin(camera.r+math.pi/2)*SHIP_SPEED*0.15
          end
        end

        camVX = camVX + (targetVX - camVX) * CAMERA_SMOOTHING * dt
        camVY = camVY + (targetVY - camVY) * CAMERA_SMOOTHING * dt

        camera.x = camera.x + camVX * dt
        camera.y = camera.y + camVY * dt

        if camera.x < CAMERA_MIN then
            camera.x = CAMERA_MIN + 1
            camVX = 0
        end
        if camera.x > CAMERA_MAX then
            camera.x = CAMERA_MAX - 1
            camVX = 0
        end
        if camera.y < CAMERA_MIN then
            camera.y = CAMERA_MIN + 1
            camVY = 0
        end
        if camera.y > CAMERA_MAX then
            camera.y = CAMERA_MAX - 1
            camVY = 0
        end

          if love.keyboard.isDown("escape") then
                        state.switch("quit")
          end

          if love.keyboard.isDown(controls.get('action')) then
            action()
          end
end

function love.draw()
        --Set Background iMAGE and calculate resize to fit the whole window resolution
        local sx = love.graphics.getWidth() / imgBG:getWidth()
        local sy = love.graphics.getHeight() / imgBG:getHeight()
        love.graphics.draw(imgBG, 0, 0, 0, sx, sy)
        --DRAW Mode7 stuff
        PM7.drawPlane(camera,imgPLANE7, nil, nil, 10, 10)  --set sx / sy FOR MAP
        --PLACE Sprites  --PLANETS, SPRiTES, OJee ... OH MY!!!
        --Planets{}
        for k,v in pairs(planets) do
                if planets[k]["live"] == true then
                        PM7.placeSprite(camera,
                        planets[k]["img"],
                        planets[k]["quad"],
                        planets[k]["x"],planets[k]["y"],0,planets[k]["imgSX"],planets[k]["imgSY"],planets[k]["quadWidth"],planets[k]["quadHeight"])
                end
        end
        --RENDER Sprites
        PM7.renderSprites(camera)
        --COMPASS stuff
        local rrr = ""
        if camera.r > -0.5 and camera.r < 1.5 then
                rrr = "NORTHERNiSH "
        elseif camera.r > 1.5 and camera.r < 3 then
                rrr = "EASTERNiSH "
        elseif camera.r > 3 and camera.r < 4.5 then
                rrr = "SOUTHERNiSH "
        elseif camera.r > 4.5 and camera.r < 6.5 then
                rrr = "WESTERNiSH "
        end
        love.graphics.print("[HEADiNG] " .. rrr)
        love.graphics.print("\n[SECTOR] ( ".. math.floor(camera.x/100) ..", ".. math.floor(camera.y/100) .. " )")
        love.graphics.draw(imgCOMPASS,111,111,camera.r,0.5,0.5,imgCOMPASS:getWidth()/2,imgCOMPASS:getHeight()/2)
        --draws imgSHIP
        local s = 0.666
        local x = love.graphics.getWidth()/2 + 7
        local y = love.graphics.getHeight()/2 - 40 --love.graphics.getHeight() * 0.865
        local xx, yy = 0,0
        if shipDirection == 0 then
                aniSHIP0:draw(imgSHIP0, x, y, shipROT, s, s,shipOFF,shipOFF)
        elseif shipDirection == 1 then
                xx = x + love.math.random(1, 20)
                yy = y + love.math.random(1, 20)
                aniSHIP1:draw(imgSHIP1, xx, yy, shipROT, s, s,shipOFF,shipOFF)
        end
        --CORNER'S OF THE UNiVERSE
        PM7.placeSprite(camera,spriteimg,5020,5020,0,25,25, 250, 250)  --( CAMERA , IMAGE , X, Y, ROTATION, SX, SY)
        PM7.placeSprite(camera,spriteimg,0,0,0,25,25, 250, 250)
        PM7.placeSprite(camera,spriteimg,0,CAMERA_MAX,0,25,25, 250, 250)
        PM7.placeSprite(camera,spriteimg,CAMERA_MAX,0,0,25,25, 250, 250)
        PM7.placeSprite(camera,spriteimg,CAMERA_MAX,CAMERA_MAX,0,25,25, 250, 250)
        --MOAN LAST
        Moan.draw()
end

function love.keyreleased(key)
    Moan.keyreleased(key) -- or Moan.keypressed(key)
    if key == controls.get('up') then
        shipDirection = 0
    end
    sndSHIP:stop()
    shipROT = 0
end

function action()
        for k,v in pairs(planets) do
                local distance = distance(planets[k]["x"],planets[k]["y"], camera.x, camera.y)
                if distance < 100 and planets[k]["live"] == true then
                        planets[k].visited = true
                        state.switch(planets[k]["state"], k)
                end
        end
end

function distance(x1, y1, x2, y2) return math.sqrt( (x1-x2)^2 + (y1-y2)^2 ) end

function updateQuadState(a)
        if a[3] < a[1] then a[3] = a[3] + 1 else
                a[3] = 0
                if a[4] < a[2] then a[4] = a[4] + 1 else a[4] = 0 end
        end
        if a[4] == a[2] and a[3] == a[5] then a[3] = 0 a[4] = 0 end  --STOP VALUE CODE
        return a
end

function love.quit()
    saveProgress()
    if sndBGMain then
        sndBGMain:stop()
        sndBGMain:release()
        sndBGMain = nil
    end
    if sndSHIP then
        sndSHIP:stop()
        sndSHIP:release()
        sndSHIP = nil
    end
    if PM7 and PM7.destroyCamera then -- free Playmat resources
        PM7.destroyCamera()
    end
    if assets and assets.clear then
        assets.clear()
    end
end

return setup
