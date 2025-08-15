# Suggestions for Production Readiness

The repository was reviewed file‑by‑file.  Below are recommendations to polish the game, address technical issues and prepare it for a public release.

## 1. Fix Mode 7 Memory Usage
- `lib/playmat.lua` creates temporary tables for every sprite via `placeSprite`, which can allocate many tables per frame.  Reuse tables or clear them with `table.clear`/`table.remove` to reduce garbage.
- Ensure canvases and shaders are reused rather than recreated, and call `collectgarbage` or profiling tools to confirm memory is stable.
- Consider using sprite batching or Love's `SpriteBatch` to further reduce allocations.

## 2. Reduce Global State
- Many scripts expose globals (`luacheck` reports 1000+ warnings).  Encapsulate logic in modules or local tables to avoid name clashes and ease testing.

## 3. Asset Management
- `planets/data/planets.lua` loads images on require.  Cache assets in a central loader so state changes do not reload textures every visit.
- Compress or atlas textures to lower memory footprint and load times.

## 4. Code Structure and Documentation
- Organize planet scripts into a unified system or data-driven structure rather than separate files for each planet.
- Replace hard-coded magic numbers (e.g., coordinates, speeds) with configuration constants.
- Expand documentation and inline comments describing game flow and engine APIs.

## 5. Testing and Tooling
- Add automated checks (e.g., Luacheck configuration, unit tests for state transitions) to catch regressions.
- Provide a build script or instructions for packaging the game for Windows, macOS, and Linux.

## 6. Gameplay and UX Improvements
- Add title and pause screens, configurable key bindings, and audio options.
- Implement save/load functionality and progress tracking.

Addressing these items will help stabilize the Mode 7 renderer, reduce memory leaks, and make the project easier to maintain and ship.

