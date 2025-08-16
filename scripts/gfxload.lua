shipDirection = 0
shipROT = 0
shipOFF = 200
shipQUEST = 0

-- Quest progression values:
--   0  start on Planet Andros
--   1  visit Planet Green to begin the quest
--   2  help Planet Purple
--   3  assist Planet Pink
--   4  search Planet Andros again
--   5  keep searching Planet Andros
--   6  still searching Planet Andros
--   7  return to Planet Green for a signal
--   8  final visit to Planet Andros
--   9  destroy the asteroid and finish on Planet Green

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
