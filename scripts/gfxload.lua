shipDirection = 0
shipROT = 0
shipOFF = 200
shipQUEST = 0

--BASiC
love.graphics.setBackgroundColor(0,0,0)
love.graphics.setDefaultFilter("nearest","nearest")
Moan.setSpeed(0.1)
love.mouse.setVisible(false)

--LOAD iMAGES
imgPLANE7 = love.graphics.newImage("assets/maps/stars10000.png")
imgBG = love.graphics.newImage("assets/maps/spacey.jpg")
spriteimg = love.graphics.newImage("assets/sprites/yeehaw.png")
imgCOMPASS = love.graphics.newImage('assets/sprites/imgCOMPASS.png')

--SHiP ANiMATiONS
imgSHIP0 = love.graphics.newImage("assets/sprites/ship0.png")
gridSHIP0 = anim8.newGrid(400, 400, imgSHIP0:getWidth(), imgSHIP0:getHeight())
aniSHIP0 = anim8.newAnimation(gridSHIP0('1-8',1), 0.2)

imgSHIP1 = love.graphics.newImage("assets/sprites/ship1.png")
gridSHIP1 = anim8.newGrid(400, 400, imgSHIP1:getWidth(), imgSHIP1:getHeight())
aniSHIP1 = anim8.newAnimation(gridSHIP1('1-4',1), 0.2)

--PLAYER PERSPECTiVE VARiABLES
camera = PM7.newCamera(love.graphics.getWidth(),love.graphics.getHeight())  --set CAMERA to WiNDOW SCREEN SiZE
camera:setZoom(100)  --set ZOOM
camera:setFov(2) --set FOV
camera:setOffset(0.333) --set OFFSET
