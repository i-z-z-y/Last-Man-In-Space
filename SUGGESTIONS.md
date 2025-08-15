# Suggestions for Production Readiness

The repository was reviewed file‑by‑file.  Below are recommendations to polish the game, address technical issues and prepare it for a public release.

## 1. Fix Mode 7 Memory Usage
- `lib/playmat.lua`'s `placeSprite` assembles an argument table and pushes it into `cam.buffer` (`table.insert`) every frame.  These tables are discarded after `renderSprites`, causing steady allocation and memory churn.  Reuse table objects or convert the renderer to operate on a preallocated array.
- Profile `PM7.drawPlane` and `renderSprites` with a memory tool; ensure the shader and canvas created in `newCamera` are reused across frames.
- If Playmat remains a bottleneck, replace per‑sprite buffers with `love.graphics.newSpriteBatch` to draw planets and ship sprites efficiently.

## 2. Reduce Global State
- Files such as `scripts/gfxload.lua` and each `planets/*.lua` set or rely on globals (`shipDirection`, `shipQUEST`, `camera`, `state`, `passvar`).  Wrap these in modules or local tables and return explicit interfaces.
- `lib/switch.lua` mutates a global `passvar` table to pass state data.  Consider using Love's built‑in `arg` or a dedicated state machine library to avoid hidden dependencies.

## 3. Asset Management
- `planets/data/planets.lua` calls `love.graphics.newImage` during module load for every planet.  Lazy‑load or share textures via an asset cache so re‑requiring the module does not duplicate Image objects.
- Audio sources like `sndBGMain` and `sndSHIP` in `main.lua` are created in `love.load` but never released.  Store them in a manager and stop/cleanup on shutdown.
- Combine small sprite sheets into atlases and provide a manifest to reduce file count and improve loading times.

## 4. Code Structure and Documentation
- Planet interaction logic is duplicated across `planets/planet*.lua`.  Replace with a single handler reading dialogue and quest steps from data tables.
- Extract repeated numbers such as camera limits (4000–96000) and ship speed (300) in `main.lua` into named constants or configuration files.
- Add comments describing how `shipQUEST` progresses and how `PM7` integrates with LÖVE to help future contributors.

## 5. Testing and Tooling
- Add automated checks such as a `luacheck` configuration for style and a small test script verifying `state.switch` and planet data.
- Provide a packaging script (e.g., `make` or Lua script) that assembles a `.love` file and platform‑specific builds for Windows, macOS, and Linux.

## 6. Gameplay and UX Improvements
- Implement title/pause screens, configurable controls, and audio sliders via `Moan` options.
- Add save/load or checkpoint support so `shipQUEST` progress and visited planets persist across sessions.

Addressing these items will help stabilize the Mode 7 renderer, reduce memory leaks, and make the project easier to maintain and ship.

