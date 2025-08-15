# Production Tasks

Detailed action items derived from the code review and `SUGGESTIONS.md`.  Completing these will prepare *Last Man In Space* for a production release.

## Mode 7 / Playmat Memory Leak
- [ ] Refactor `lib/playmat.lua` `placeSprite` to reuse sprite records instead of creating a new table per sprite each frame.
- [ ] Ensure `PM7.newCamera` only creates one `rendercanvas`; add a teardown path to release the canvas on shutdown.
- [ ] Benchmark `PM7.drawPlane` and `PM7.renderSprites` with `love.graphics.getStats()` and document memory numbers before/after optimisation.
- [ ] Prototype a `love.graphics.newSpriteBatch` renderer and compare performance to the current buffer approach.

## Global State Cleanup
- [ ] Convert `scripts/gfxload.lua` into a module that returns images, animations, and a `setupCamera` function instead of setting globals.
- [ ] Replace `lib/switch.lua` and `passvar` with a state manager that passes arguments explicitly.  Update `main.lua`, `info.lua`, and `planets/*.lua` accordingly.
- [ ] Implement a `Planet` handler module so individual `planets/planet*.lua` scripts can be data‑driven.

## Asset Management
- [ ] Introduce an `assets.lua` cache.  Modify `planets/data/planets.lua` and `scripts/gfxload.lua` to request images through this cache.
- [ ] Add shutdown code in `main.lua` to stop and release `sndBGMain` and `sndSHIP`.
- [ ] Merge sprite sheets into atlases and update `anim8.newGrid` calls to use atlas coordinates.
- [ ] Track and reuse fonts (`JPfallback.ttf`, `Pixel UniCode.ttf`) through the asset cache.

## Code Structure and Documentation
- [ ] Replace duplicated planet scripts with a generic `planet_scene.lua` that reads quest/dialogue data from `planets/data/planets.lua`.
- [ ] Introduce constants for camera bounds, ship speed, and animation timings in `main.lua` and reference them everywhere.
- [ ] Expand comments in `lib/playmat.lua` explaining shader variables and `cam` fields.
- [ ] Document `shipQUEST` progression in `README.md` and code comments.

## Testing and Packaging
- [ ] Add `.luacheckrc` and integrate `luacheck` into CI to catch globals and style issues.
- [ ] Write a validation script for `planets/data/planets.lua` ensuring each entry has `img`, `imgPS`, and valid quad dimensions.
- [ ] Create a `Makefile` or `build.lua` that packages the project into a `.love` file and optional platform executables.

## Gameplay and UX
- [ ] Build a title screen state with instructions and a menu to start or quit the game.
- [ ] Add configurable key bindings stored in a `controls.lua` file and accessible via an options menu implemented with `Moan`.
- [ ] Persist `shipQUEST`, `camera` position, and visited planets using `love.filesystem` so progress survives restarts.

