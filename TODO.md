# Production Tasks

Action items extracted from `SUGGESTIONS.md`.  Completing these will bring *Last Man In Space* to a releasable state.

## Renderer and Performance
- [ ] Compare `lib.playmat.renderSprites` with `renderSpritesBatch` and adopt the faster variant.
- [ ] Ensure `game.lua` calls `PM7.destroyCamera()` on shutdown and document the API.
- [ ] Integrate `scripts/benchmark_pm7.lua` into CI and track `love.graphics.getStats()` output.

## Input and Options
- [ ] Escape and quote key names when writing `controls.conf` to avoid corrupt files.
- [ ] Detect conflicting key assignments in `controls.set` and add a "reset defaults" option.
- [ ] In `options.lua`, allow cancelling a rebind with `escape` and redraw the menu immediately.
- [ ] Show the current binding while awaiting input so players know what is being changed.

## Persistence
- [ ] Replace the custom `serialize` function in `game.lua` with JSON (e.g. `dkjson`).
- [ ] Validate loaded save data and back up the previous file before overwriting.
- [ ] Move `visited` flags into `planets/data/planets.lua` instead of adding fields at runtime.

## Assets
- [ ] Add `assets.clear()` to release cached images/fonts and call it from `love.quit`.
- [ ] Release the temporary canvas in `scripts/gfxload.lua` after building the ship atlas.
- [ ] Deduplicate planet background images by referencing shared assets.

## Code Structure
- [ ] Extract gameplay constants from `game.lua` into a configuration module.
- [ ] Document the `controls.conf` format and default mappings in `README.md`.
- [ ] Comment the expected `config` structure in `planets/planet_scene.lua`.
- [ ] Remove or refactor `info.lua` to reuse logic from `planet_scene.lua`.

## Testing
- [ ] Add a `.luacheckrc` and run `luacheck` in the build pipeline.
- [ ] Extend `scripts/validate_planets.py` to check `quadState`, `imgSX` and `imgSY` ranges.
- [ ] Write unit tests for `controls.lua` load/save behaviour.

## Gameplay and UX
- [ ] Implement camera acceleration for smoother short movements.
- [ ] Highlight the selected teleporter destination and allow instant cancel with `escape`.
- [ ] Add background art, music and version text to `title.lua`.
- [ ] Play an effect whenever `shipQUEST` advances to reinforce progression.

## Build and Distribution
- [ ] Cache downloaded Love2D binaries in the `Makefile` and verify checksums.
- [ ] Create a `make test` target that runs linters and validation scripts before packaging.
- [ ] Note Python 3 and Pillow as prerequisites in the README.
