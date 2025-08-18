local assets = require("assets")
local XY = ""
local planets = {}
--EACH PLANET HAS UNiQUE KEY VALUE PAiR FROM AMALGAM OF X,Y COORDiNATES AS A STRiNG THAT ALSO SERVERS AS THE iNDEX
--TEMPLATE...
  XY="X123Y123"
  planets[XY] = {
    x=123,
    y=123,
    live=false,
    visited=false,
    name="Planet Name",
    state="planets.planetName",
    img=assets.image("planets/assets/planetName.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetNameScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={8,8,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=311,
    quadHeight=311,
    imgSX=50,
    imgSY=50
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X0Y0"
  planets[XY] = {
    x=0,
    y=0,
    live=false,
    visited=false,
    name="Planet Name",
    state="planets.planetName",
    img=assets.image("planets/assets/planetName.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetNameScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={8,8,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=311,
    quadHeight=311,
    imgSX=50,
    imgSY=50
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X5100Y5100"
  planets[XY] = {
    x=5100,
    y=5100,
    live=true,
    visited=false,
    name="Planet Andros",
    state="planets.planetAndros",
    img=assets.image("planets/assets/planetAndros.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetAndrosScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,5,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=175,
    quadHeight=175,
    imgSX=55,
    imgSY=55
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X7777Y5555"
  planets[XY] = {
    x=7777,
    y=5555,
    live=true,
    visited=false,
    name="Planet Pink",
    state="planets.planetPink",
    img=assets.image("planets/assets/planetPink.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetPinkScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={8,8,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=311,
    quadHeight=311,
    imgSX=50,
    imgSY=50
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X5555Y5555"
  planets[XY] = {
    x=5555,
    y=5555,
    live=true,
    visited=false,
    name="Asteroid",
    state="planets.asteroid",
    img=assets.image("planets/assets/asteroid.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/asteroidScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,5,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=175,
    quadHeight=175,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X55555Y55555"
  planets[XY] = {
    x=55555,
    y=55555,
    live=true,
    visited=false,
    name="Planet Green Gals",
    state="planets.planetGreen",
    img=assets.image("planets/assets/planetGreen.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetGreenScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={8,8,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=311,
    quadHeight=311,
    imgSX=50,
    imgSY=50
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X99999Y99999"
  planets[XY] = {
    x=95900,
    y=95900,
    live=true,
    visited=false,
    name="Planet Purple Gals",
    state="planets.planetPurple",
    img=assets.image("planets/assets/planetPurple.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/planetPurpleScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={8,8,0,0,4}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=311,
    quadHeight=311,
    imgSX=50,
    imgSY=50
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X77777Y77777"
  planets[XY] = {
    x=77777,
    y=77777,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )


  XY="X5000Y5000"
  planets[XY] = {
    x=5000,
    y=5000,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X95000Y5000"
  planets[XY] = {
    x=95000,
    y=5000,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X5000Y95000"
  planets[XY] = {
    x=5000,
    y=95000,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X95000Y95000"
  planets[XY] = {
    x=95000,
    y=95000,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

  XY="X55000Y55000"
  planets[XY] = {
    x=55000,
    y=55000,
    live=true,
    visited=false,
    name="OJEE",
    state="planets.OJEE",
    img=assets.image("planets/assets/OJEE.png"), --SPRiTE FOR MODE7
    imgPS=assets.image("planets/assets/OJEEScreen.png"), --BACKGROUND FOR PLANET SCREEN
    quadState={4,1,0,0,0}, --MAX ROW, MAX COLUMN, CURRENT ROW, CURRENT COLUMN, STOP LAST ROW'S COLUMN VALUE
    quadWidth=128,
    quadHeight=128,
    imgSX=20,
    imgSY=20
  }
  planets[XY]["quad"] = love.graphics.newQuad( 0, 0, planets[XY]["quadWidth"], planets[XY]["quadHeight"],planets[XY]["img"]:getDimensions() )

return planets
