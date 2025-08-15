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

All Lua files in the project were reviewed to map out their dependencies.  The game uses:

- **LÖVE 11.x** – core framework.  Code throughout the repo calls `love.graphics` for drawing, `love.audio` for music and sfx,
  `love.keyboard` and `love.mouse` for input, `love.math` for randomness and trigonometry, and `love.event` for quitting.
- **Playmat (Mode 7)** – `lib/playmat.lua` provides a GLSL shader, camera math, and sprite buffer for the pseudo‑3D starfield.
  Functions like `PM7.drawPlane`, `PM7.placeSprite`, and `PM7.renderSprites` are invoked in `main.lua` to render the world.
- **Anim8** – `lib/anim8.lua` supplies `newGrid` and `newAnimation` helpers.  `scripts/gfxload.lua` uses them to animate the ship
  sprite sheets.
- **Moan** – `lib/moan.lua` implements the dialogue system with typewriter text, options, and sound effects.  It is used in the
  main loop, planet scripts, and `quit.lua`.
- **Switch** – `lib/switch.lua` reloads states and passes parameters through the global `passvar` table via `state.switch()`.
- **utf8** – required by `lib/moan.lua` to handle multibyte characters.

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
| `planets/*.lua` | Individual planet interactions manipulating `shipQUEST` and switching states. | `state`, `Moan`, `love.graphics`, `love.event` |
| `planets/data/planets.lua` | Loads planet positions, sprites, and quad definitions. | `love.graphics`, `table` |

All Lua source files were examined to generate the above mapping and library list.

## Running

Ensure [LÖVE](https://love2d.org/) is installed and run the game from the repository root:

```bash
love .
```

## License

Each third‑party library in `lib/` contains its own license header.  Project assets and game code are provided as‑is for educational purposes.

