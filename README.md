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

The project relies on several libraries:

- **LÖVE 11.x** – game framework providing graphics, audio and input APIs used throughout the project.
- **Playmat (Mode 7)** – `lib/playmat.lua` implements Mode 7 style rendering and sprite placement.
- **Anim8** – `lib/anim8.lua` for sprite sheet based animations.
- **Moan** – `lib/moan.lua` to display dialogue boxes and text with typewriter effects.
- **Switch** – `lib/switch.lua` for simple state switching and parameter passing between scenes.

All Lua source files in this repository have been reviewed to generate this summary and library list.

## Running

Ensure [LÖVE](https://love2d.org/) is installed and run the game from the repository root:

```bash
love .
```

## License

Each third‑party library in `lib/` contains its own license header.  Project assets and game code are provided as‑is for educational purposes.

