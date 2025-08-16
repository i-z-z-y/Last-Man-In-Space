# Suggestions for Production Readiness

The entire repository was reviewed.  The notes below reference each module and recommend precise changes required to ship a stable build.

## 1. Mode‑7 Renderer and Performance
- `lib/playmat.lua` now recycles sprite tables and shares a render canvas, but `renderSprites` still sorts Lua tables every frame.  Benchmark `renderSpritesBatch` and adopt it if it reduces CPU time.
- Expose a `PM7.destroyCamera` call in the public API (already implemented) and ensure `game.lua` invokes it on `love.quit` to free the shared canvas.
- `scripts/benchmark_pm7.lua` draws 100 planes and sprites.  Wire this into CI and capture `love.graphics.getStats()` output to detect regressions in texture memory.

## 2. Input and Options System
- `controls.lua` serialises mappings with a custom `serialize` function that does not escape quotes or backslashes.  Use `string.format('%q')` on the key names when writing `controls.conf` to avoid corrupt files.
- Add conflict detection in `controls.set`: warn when two actions are bound to the same key and offer a reset-to-defaults option.
- In `options.lua`, pressing `escape` while awaiting a new key leaves the system in a waiting state.  Handle cancellation and redraw the menu immediately so the user is not trapped.
- Display the current mapping while waiting for input (`"Press new key (current: %s)"`).

## 3. Persistence and Save Data
- `game.lua`'s `serialize` routine builds Lua code manually.  Switch to a robust format such as JSON via a small library (e.g. `dkjson`) to handle booleans and nested tables safely.
- When loading progress, validate the structure before applying it to avoid crashes from malformed save files.  Backup the previous save before overwriting.
- Mark `planets[k].visited` in `planets/data/planets.lua` rather than attaching dynamic fields to the global table to keep data definitions immutable.

## 4. Asset Management
- `assets.lua` caches `love.graphics.newImage` objects but never releases them.  Provide a `assets.clear()` routine called from `love.quit` to free images and fonts in long sessions.
- `scripts/gfxload.lua` assembles an atlas using `love.graphics.newCanvas` but never destroys the canvas image.  After creating `atlas`, call `atlasCanvas:release()` to return VRAM.
- Consolidate repeated background images in `planets/` by referencing shared assets to reduce duplicates on disk.

## 5. Code Structure and Documentation
- `game.lua` defines numerous magic numbers (`CAMERA_MIN`, `CAMERA_MAX`, `SHIP_SPEED`, `ANIM_FRAME_TIME`, etc.).  Move these into a dedicated configuration module so designers can tune them without touching code.
- Document `controls.conf` format in `README.md` and mention the default key map.
- Add inline comments to `planets/planet_scene.lua` describing the expected shape of the `config` table (`avatar`, `intro`, `dialogue` indexes) to simplify creation of new planets.
- `info.lua` duplicates background drawing logic found in `planet_scene.lua`.  Refactor it to use the same helper or remove the file if no longer required.

## 6. Testing and Tooling
- Create a `.luacheckrc` listing allowed globals (`love`, `state`, `Moan`, `camera`, etc.) and run `luacheck` in CI.  The current environment lacks `luacheck` – install it via LuaRocks in the build pipeline.
- Expand `scripts/validate_planets.py` to verify `quadState` dimensions and ensure `imgSX`/`imgSY` fall within sensible ranges.  Include it in automated tests.
- Add unit tests for `controls.lua` to ensure changes in `controls.conf` persist and corrupt files are handled gracefully.

## 7. Gameplay and UX
- Implement gradual camera acceleration in `game.lua` so short taps nudge the ship instead of instantly jumping to full speed.
- Teleporter `planets/OJEE.lua` displays labelled sectors; highlight the currently selected sector and allow quick exit with `escape` without clearing messages first.
- Add a background image and music to `title.lua` to make the opening screen less stark.  Show the current version string built from `git describe --tags`.
- In dialogue sequences, play a short animation or sound when `shipQUEST` advances to provide feedback.

## 8. Build and Distribution
- The `Makefile` downloads platform binaries every invocation.  Cache the archives in `dist/` and add checksum verification so repeated builds are faster and safer.
- Provide a `make test` target that runs `scripts/validate_planets.py` and any Lua linters before packaging.
- Document required external tools (Python 3 + Pillow) in the README's Running section so contributors can execute validation scripts.

Implementing these items will reduce the risk of resource leaks, make the control system user‑friendly, and ensure the project is maintainable as it approaches a public release.
