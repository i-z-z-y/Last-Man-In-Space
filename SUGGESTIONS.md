# Suggestions for Production Readiness

The repository was reviewed file‑by‑file.  Below are recommendations to polish the game, address technical issues and prepare it for a public release.

## 1. Fix Mode 7 Memory Usage
- In `lib/playmat.lua` the `placeSprite` routine builds a fresh table for every call and pushes it into `cam.buffer`.  The table contains quad, coordinates, scale, offsets and a copy of the current colour.  `renderSprites` sorts and draws these tables and then resets `cam.buffer = {}`.  This per‑frame allocation is the primary memory leak.  Implement an object pool (e.g., recycle table objects or store sprite records in a preallocated array indexed by sprite ID) so the garbage collector does not churn each frame.
- `PM7.newCamera` allocates a `rendercanvas` and stores shader handles.  Verify that only one camera is created and reused, and free canvases when unloading to avoid leaking GPU memory.
- Profile both `PM7.drawPlane` and `PM7.renderSprites` with LuaJIT's `-jv` or the built‑in `love.graphics.getStats()` to confirm the leak and validate improvements.
- If Playmat remains a bottleneck, replace the per‑sprite table buffer with `love.graphics.newSpriteBatch` and issue `:add` calls for each planet instead of sorting Lua tables.

## 2. Reduce Global State
- `scripts/gfxload.lua` defines globals (`imgSHIP0`, `aniSHIP0`, `camera`, `PM7`) on load.  Encapsulate this in a module that returns an initialisation function and an object containing the images and animations.
- Each `planets/planet*.lua` reads and writes globals like `shipQUEST` and `state`.  Replace these loose dependencies with a `Planet` module that accepts the current quest state and returns dialogue/actions to perform.
- `lib/switch.lua` leverages a global `passvar` array to ferry arguments between states, complicating reasoning about data flow.  Swap it for a small state manager that calls functions with explicit parameters or adopt an existing framework such as [hump.gamestate](https://github.com/vrld/hump).

## 3. Asset Management
- `planets/data/planets.lua` preloads every texture when required, meaning repeated `require` calls will create duplicate `Image` objects.  Introduce an `assets` module that caches images and returns shared references.
- In `main.lua`, `sndBGMain` and `sndSHIP` are instantiated with `love.audio.newSource` and never stopped or set to `nil` on exit.  Provide a shutdown routine to call `:stop()` and release references so the garbage collector can reclaim them.
- Consolidate `assets/sprites/*.png` into one atlas per animation and update `scripts/gfxload.lua` to pull quads from the atlas via `anim8` grids.
- Track loaded fonts in `main.lua` (`JPfallback.ttf`, `Pixel UniCode.ttf`) and reuse them instead of creating new instances in other states.

## 4. Code Structure and Documentation
- Planet scripts share the same pattern: load a background, call `Moan.speak` with quest‑specific lines, and listen for `escape`.  Create a generic `planet_scene.lua` that takes a planet ID and a quest definition table to remove duplication and centralise logic.
- In `main.lua` camera bounds (4000–96000), ship speed (300) and animation timers (0.125) are magic numbers.  Move them into constants (`CAMERA_MIN`, `CAMERA_MAX`, `SHIP_SPEED`, etc.) or external config to ease balancing.
- Document the global flow of `shipQUEST` in a README section or comments: which value ranges correspond to which quest steps and which planet files mutate it.
- Inline comments in `lib/playmat.lua` are sparse around the shader math.  Expand them to describe the coordinate transforms and meaning of the `cam` table fields for future maintainers.

## 5. Testing and Tooling
- Add a `.luacheckrc` defining allowed globals (`love`, `state`, `Moan`, etc.) and run `luacheck` in CI to catch accidental globals like those reported in `scripts/gfxload.lua`.
- Write a tiny Lua script that loads `planets/data/planets.lua` and asserts that each entry contains `img`, `imgPS`, and valid `quad` dimensions so corrupted assets are detected early.
- Provide a `Makefile` or `script/build.lua` that zips the project into a `.love` file and, if a platform SDK is present, packages Windows/macOS/Linux binaries.

## 6. Gameplay and UX Improvements
- Create a simple title screen (`state.switch("title")`) that shows instructions before `main.lua` starts the game loop.
- Allow rebinding of `WASD`, `QE`, and `F` by storing control mappings in a `controls.lua` file and exposing an options menu through `Moan`.
- Persist `shipQUEST`, `camera.x`, and visited planets using `love.filesystem.write`/`read` so progress survives restarts.
- Implement camera smoothing or acceleration in `main.lua` so short movements do not snap the view, addressing player reports of janky control.
- Update `planets/OJEE.lua` to annotate teleport options with destination planet names and highlight sectors the player has already visited.
- Fix the second conversation on Planet Green that stops mid‑paragraph by revisiting the `shipQUEST` conditional in `planets/planetGreen.lua` and validating `Moan.speak` sequences.
- Flesh out quest branches for `planets/planetPink.lua` and `planets/planetPurple.lua` so their arcs resolve instead of ending abruptly.

## 7. Cross‑Platform Distribution
- Provide platform builds beyond Windows.  Create scripts to bundle the `.love` file with Linux and macOS runners and evaluate [Love.js](https://github.com/TannerRogalsky/love.js) for an in‑browser version.

Addressing these items will help stabilize the Mode 7 renderer, reduce memory leaks, and make the project easier to maintain and ship.

