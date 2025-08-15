state = require "lib.switch"
PM7 = require "lib.playmat"
anim8 = require 'lib.anim8'
Moan = require('lib.moan')

require('planets.data.planets')  -- X, Y  --holds PLANETS

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
function love.load()
	require('scripts.gfxload')
	--START POSiTiON ViA CAMERA
	camera.x, camera.y = 5000,5000
	--MUSiC
	sndBGMain = love.audio.newSource("assets/music.ogg", "stream")
	sndBGMain:setVolume(0.11)
	sndBGMain:setLooping(true)
	sndBGMain:play()
	--SHiP SOUNDS
	sndSHIP = love.audio.newSource("assets/propulsion.wav", "static")
	sndSHIP:setVolume(0.1)
	--MOAN
	Moan.font = love.graphics.newFont("assets/JPfallback.ttf", 32)
	local JPfallback = love.graphics.newFont("assets/Pixel UniCode.ttf", 32)
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
	Moan.noImage = love.graphics.newImage("assets/avatars/nif.png")
	--GAME iNSTRUCTiONS
	Moan.speak("STAR T", {"W A S D to MOVE... Q E to TURN... F for action... ESCAPE to quit..."})
end
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
local speed = 300  --SPEEEEEEEEEEEEEEEEEEED!
local frame = 0
local framey = 0
local frameX = 0
local frametime = 0

function love.update(dt)
	aniSHIP0:update(dt)  --OUR SHIP
	aniSHIP1:update(dt)  --OUR SHIP

	Moan.update(dt)
	frametime = frametime + dt
	if frametime > 0.125 then  --8 FPS --QUAD CODE
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
	if not (camera.x < 4000 or camera.x > 96000 or camera.y < 4000 or camera.y > 96000) then
	  if love.keyboard.isDown("q") then
	    camera:setRotation(camera:getRotation()-dt)
			shipROT = -0.5
	  elseif love.keyboard.isDown("e") then
	    camera:setRotation(camera:getRotation()+dt)
			shipROT = 0.5
	  end
	  if love.keyboard.isDown("w") then
	    camera.x=camera.x+math.cos(camera.r)*speed*dt
	    camera.y=camera.y+math.sin(camera.r)*speed*dt
			shipDirection = 1
			sndSHIP:play()
	  elseif  love.keyboard.isDown("s") then
	    camera.x=camera.x-math.cos(camera.r)*speed*dt*0.15
	    camera.y=camera.y-math.sin(camera.r)*speed*dt*0.15
	  end

	  if love.keyboard.isDown("a") then
	    camera.x=camera.x+math.cos(camera.r-math.pi/2)*speed*dt*0.15
	    camera.y=camera.y+math.sin(camera.r-math.pi/2)*speed*dt*0.15
	  elseif  love.keyboard.isDown("d") then
	    camera.x=camera.x+math.cos(camera.r+math.pi/2)*speed*dt*0.15
	    camera.y=camera.y+math.sin(camera.r+math.pi/2)*speed*dt*0.15
	  end
	else
		if camera.x < 4000 then
			camera.x = 4001
		end
		if camera.x > 96000 then
			camera.x = 95999
		end
		if 		 camera.y < 4000 then
			camera.y = 4001
		end
		if 		 camera.y > 96000 then
			camera.y = 95999
		end
	end

	  if love.keyboard.isDown("escape") then
			state.switch("quit")
	  end

	  if love.keyboard.isDown("f") then
	    action()
	  end
end
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
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
	love.graphics.print("[HEADiNG] " .. rrr)-- .. camera.r)
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
	PM7.placeSprite(camera,spriteimg,0,96000,0,25,25, 250, 250)
	PM7.placeSprite(camera,spriteimg,96000,0,0,25,25, 250, 250)
	PM7.placeSprite(camera,spriteimg,96000,96000,0,25,25, 250, 250)
	--MOAN LAST
	Moan.draw()
end
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
function love.keyreleased(key)
    Moan.keyreleased(key) -- or Moan.keypressed(key)
		if key == "w" then
			shipDirection = 0
		end
		sndSHIP:stop()
		shipROT = 0
end

function action()
	for k,v in pairs(planets) do
		local distance = distance(planets[k]["x"],planets[k]["y"], camera.x, camera.y)
		if distance < 100 and planets[k]["live"] == true then
			state.switch(planets[k]["state"] .. ";" .. k)
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
