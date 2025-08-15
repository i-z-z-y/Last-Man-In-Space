# Last Man In Space

Last Man In Space is a 2D space exploration demo built with the [LÖVE](https://love2d.org/) framework.  The game renders a Mode 7 style star field, lets players pilot a ship between planets, and shows dialogue-driven interactions when planets are encountered.

## Game Structure

- `main.lua` – core game loop, input handling, camera control and Mode 7 drawing.
- `info.lua` – displays planet information.
- `quit.lua` – exit confirmation screen.
- `scripts/` – helper scripts such as `gfxload.lua` for loading graphics and setting up the camera.
- `planets/` – individual Lua files for each planet or asteroid and a `data/planets.lua` dataset describing their positions and sprites.
- `lib/` – third-party libraries and lightweight utilities.

## Libraries and Frameworks

Every Lua source file was inspected to catalogue third‑party code and the exact APIs being invoked.

* **LÖVE 11.x** – Core runtime.  Across the repository we call:
  * `love.graphics.newImage`, `newQuad`, `draw`, `print`, `newCanvas`, and `setShader` for rendering.
  * `love.audio.newSource`, `setVolume`, `play`, `setEffect`, and `setLooping` for music and SFX.
  * `love.keyboard.isDown` and `love.keyreleased` for input polling.
  * `love.mouse.setVisible` to hide the cursor during gameplay.
  * `love.math.random` and `math` trig helpers inside the camera and ship controls.
  * `love.event.quit` in quit screens and end‑game logic.
* **Playmat v1.5** (`lib/playmat.lua`) – Mode‑7 renderer with a GLSL shader and a camera object.  Exported functions used in
  the game include `PM7.newCamera`, `PM7.drawPlane`, `PM7.placeSprite`, and `PM7.renderSprites`.  The camera exposes setters
  (`setZoom`, `setFov`, `setOffset`, `setRotation`, `setPosition`) and getters plus a sprite buffer populated every frame.
* **Anim8 v2.3.1** (`lib/anim8.lua`) – Sprite sheet helper.  `scripts/gfxload.lua` calls
  `anim8.newGrid` to slice 400×400 ship textures and `anim8.newAnimation` to produce `aniSHIP0` and `aniSHIP1` objects that are
  advanced each `love.update` tick.
* **Moan 0.2.9** (`lib/moan.lua`) – Dialogue/message box system.  The project uses `Moan.speak`, `Moan.update`, `Moan.draw`,
  and `Moan.keyreleased` in planet scripts and the quit screen.  The library also exposes configuration fields such as
  `Moan.font`, `Moan.typeSound`, and `Moan.optionOnSelectSound` that are initialised in `main.lua`.
* **Switch** (`lib/switch.lua`) – Minimal state machine.  `state.switch("file;args")` dynamically reloads a Lua module and
  populates a global `passvar` with trailing semicolon‑delimited arguments.  Planet scripts read `passvar` to obtain the planet
  key and quest information.
* **utf8** – Required by `lib/moan.lua` to support multi‑byte text rendering in dialogue.

## Lua Files and Dependencies

| File | Purpose | Libraries and APIs |
| --- | --- | --- |
| `conf.lua` | Configures window title, resize behaviour, and fullscreen. | `love.conf` |
| `info.lua` | Shows coordinates and planet name using values from `passvar`. | `state`, `love.graphics`, `love.keyboard` |
| `main.lua` | Game loop, camera control, audio, and Mode 7 drawing. | `state`, `PM7`, `anim8`, `Moan`, `love.graphics`, `love.audio`, `love.keyboard`, `love.math`, `love.event` |
| `quit.lua` | Exit confirmation dialog with options. | `state`, `Moan`, `love.graphics` |
| `scripts/gfxload.lua` | Loads images, configures ship animations, and initializes the camera. | `anim8`, `PM7`, `Moan`, `love.graphics`, `love.mouse` |
| `lib/playmat.lua` | Mode 7 library: shader, camera setters/getters, sprite placement and rendering buffer. | `love.graphics`, `math`, `table` |
| `lib/anim8.lua` | Animation helper for sprite sheets. | `love.graphics`, `table` |
| `lib/moan.lua` | Dialogue system with fonts, audio cues, and typewriter effect. | `utf8`, `love.graphics`, `love.audio`, `table` |
| `lib/switch.lua` | Minimal state loader that populates the global `passvar` table. | `string`, `package` |
| `planets/planetAndros.lua` | Handles home planet quest stages, triggers explosions, and toggles `planets[k].live`. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/planetGreen.lua` | Sets `shipQUEST` stages, uploads signals, and ends the game on success. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/planetPink.lua` | Provides coordinates to Planet Green and advances quest progression. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/planetPurple.lua` | Introduces anti‑matter lore and queries for help. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/planetName.lua` | Template interaction file with placeholder text. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/OJEE.lua` | Teleport menu that directly manipulates `camera.x`/`camera.y`. | `state`, `Moan`, `love.graphics` |
| `planets/asteroid.lua` | Quest object that disables itself and pushes player toward Planet Green. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/data/planets.lua` | Preloads images and quads for every planet/asteroid, populating a global `planets` table keyed by `"X..Y.."`. | `love.graphics`, `table` |

All Lua source files were examined to generate the above mapping and library list.

## Running

Ensure [LÖVE](https://love2d.org/) is installed and run the game from the repository root:

```bash
love .
```

## License

Each third‑party library in `lib/` contains its own license header.  Project assets and game code are provided as‑is for educational purposes.

