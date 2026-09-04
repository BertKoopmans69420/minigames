# Roadmap — Minigames

_Last updated: 2026-09-04 · Current version: 0.3_

The README lists the games in the order they happened to be written and ends with a note
to the author: _"(please order these)"_. This document is that ordering.

**Every game is a milestone.** A milestone is one game, from empty scene to something a
player can start, lose and restart. Milestones are numbered in the order the game entered
the project, not the order to work on them — for that, see _Suggested work order_ at the
bottom. Work that isn't a game (high scores, saves, the menu shell, shipping) lives in the
two system milestones at the end.

Status is written in the heading: `(Done)`, `(In Progress)`, or nothing for planned. Only
one milestone is In Progress at a time — it names the current focus.

## Where the project stands

| | Game | Milestone | State |
| --- | --- | --- | --- |
| ✅ | Pong | 1 | Complete — 1P vs CPU, 2P, first to 10 |
| ✅ | Breakout | 2 | Complete — 3 rotating layouts, 8 powerups, lives, high scores |
| ✅ | Shooter | 3 | Complete — survival timer, ramping spawn rate, high scores |
| 🔨 | Speed Typing | 4 | Playable demo — HE/NL, records held in memory only |
| 🔨 | Flapper | 5 | Walls scroll and spawn; no collision, scoring or game over |
| 🔨 | Platformer | 6 | World/level menu works; only level 1-1 exists |
| ⬜ | Snake | 7 | Empty scene, wired to a menu button |
| ⬜ | 2048 | 8 | Empty scene, wired to a menu button |
| ⬜ | Math minigame | 9 | Script exists, no scene, not routed |
| 🔨 | _Shared systems_ | 10 | Pause menu done; high scores half-migrated; save loop open |
| ⬜ | _Shipping_ | 11 | No export presets, no options, audio unhooked |

## Milestone 1: Pong (Done)

The first game, and the one that proved a game could be finished end to end.

- 1-player mode against a CPU paddle, and 2-player hot-seat.
- First to 10 points wins.
- Angle-of-reflection off the paddle, with a speed increase per hit.
- The shared button theme every later game inherited.

**Done when:** _(met)_ both modes playable to a win state and back to the menu.

## Milestone 2: Breakout (Done)

Entity variety and progression — the first game with content rather than just rules.

- Bricks with twelve strength tiers, colour-coded.
- Mouse- or key-driven paddle, three lives, flashing death animation.
- Three rotating layouts via `level % 3` from `breakout_levels.tscn`.
- Eight powerups dropping from destroyed bricks: laser, triple balls, wide/short pad,
  slower/faster balls, safe floor, extra life.
- High scores.

**Done when:** _(met)_ layouts rotate, powerups drop and expire, scores persist.

## Milestone 3: Top-down Shooter (Done)

Enemy waves and a difficulty curve.

- Twin-stick style movement with aimed bullets.
- Enemies chase the player, spawning from off-screen edges, never within 100 px.
- Spawn interval shrinks on every spawn.
- Millisecond survival timer with `set_time()` / `set_time_s()` formatting.
- High scores.

**Done when:** _(met)_ survival loop plays to a death and a score entry.

**Left open:** powerups, suggested by the commit message itself → BACKLOG FEAT-06. The
crash-on-continue and the high score panel migration belong to Milestone 10.

## Milestone 4: Speed Typing (In Progress)

The first non-action game — text input and timing rather than physics.

**Delivered:** a 26-sentence Hebrew corpus, HE/NL language toggle, a timer started by a
dedicated input action, per-language best times shown on screen.

**Remaining:**

1. **Persist the records.** Best times live in memory only and vanish on quit; write them
   into `user://minigames.save` alongside the high score tables.
2. **Write the Dutch corpus.** The NL toggle exists with nothing behind it → BACKLOG
   BUG-07.
3. **Decide where it lives.** It is reached through a separate "typing practice" button
   rather than the main game grid — either fold it into the grid or keep the split
   deliberately.

**Done when:** a best time set today is still there tomorrow, in both languages.

## Milestone 5: Flapper

Endless scrolling and procedural obstacles. The prototype has everything except dying.

**Delivered:** parallax autoscrolling background, walls spawning every 2 s at randomised
heights, gravity-plus-impulse player.

**Remaining:** _(all BACKLOG GAME-01)_

1. Wall and ground collision → death.
2. Score on wall passed, displayed live.
3. Game over → high score entry via the shared panel.
4. Restart and exit-to-menu from the game over screen.
5. Ceiling bound so the player cannot climb out of play.

**Done when:** Flapper writes into `flapper_highscores` — already plumbed through the save
file in anticipation — and can be replayed without leaving the scene.

## Milestone 6: Platformer

The biggest single piece of remaining work, and the reason the save format already carries
worlds, lives, coins and per-player rows.

**Delivered:** world and level select with button gating from `last_completed_world` /
`last_completed_level`; a `PlatformerPlayer` with gravity, jump and horizontal
acceleration; the project's first TileSet-based floor; level 1-1.

**Remaining:**

1. Levels 1-2 through 1-6 (World 1 complete).
2. Coins, lives and a real death/respawn loop instead of returning to the menu on a fall.
3. Level completion writes `last_completed_world` / `last_completed_level` into the save.
4. Read `platformer_saves` back on load — the write side works, the read was left
   commented out → BACKLOG BUG-04.
5. Named save slots; `platformer_saves` is already keyed by player name.
6. Worlds 2 and 3, once World 1 proves the level pipeline.

**Done when:** a player can quit mid-progression and resume at the right level.

## Milestone 7: Snake

Grid movement, growth, self-collision. The simplest remaining game and the natural warm-up
for 2048's grid logic. First entirely new game since Flapper.

1. Grid movement on a fixed cell size.
2. Growth on food pickup.
3. Self- and wall-collision → game over.
4. Score into the shared high score table.
5. Restart from the game over screen.

Until this lands the menu button opens an empty scene — disable it (Milestone 10) rather
than leave a dead end. `snake_highscores` already exists in the save format.

**Done when:** the Snake button leads to a game with a start, a fail state and a score.

## Milestone 8: 2048

Reuses the grid thinking from Snake.

1. Tile grid with merge rules.
2. Spawn rules for new tiles.
3. Game over detection (no legal move).
4. Score into the shared table.

Same as Snake: the button is wired to an empty scene, and `game_2048_highscores` is
already in the save format.

**Done when:** the 2048 button leads to a game with a start, a fail state and a score.

## Milestone 9: Math minigame

`math.gd` is written but has no scene and is not routed.

1. Give it a scene and a menu route.
2. Fix its dependency on the non-existent `GameState.in_menu`.
3. Decide what it _is_ — a standalone entry, or a gate mechanic inside the platformer. It
   emits an `open_gate` signal, which suggests the latter; if so this milestone folds into
   Milestone 6 and the entry is dropped from the menu.

**Done when:** the equations are reachable from somewhere, and `math.gd` no longer
references a property that does not exist.

## Milestone 10: Shared systems

Not a game — the code every game sits on. Partly delivered across Sprints 6–9; listed here
so the open half is not invisible.

**Delivered:**

- ✅ Pause menu — global `ESC` overlay on the shell, `PROCESS_MODE_ALWAYS` so input
  arrives while the tree is paused, context-aware exit label ("menu" in a level, "home"
  otherwise).
- ✅ High score entry — three-letter names with automatic skip when the score cannot make
  the table; five-entry sorted table per game; JSON save/load at `user://minigames.save`
  with `game_version` gating and per-key fallbacks so old saves survive new games.
- ✅ Universal `HighScores` panel written, and Breakout and Shooter pointed at it.
- ✅ `sort_highscores()` generalised across every registered game.

**Remaining:**

1. Delete `breakout_high_scores.gd/.tscn` and `shooter_high_scores.gd/.tscn` — the
   per-game copies the universal panel replaced → BACKLOG BUG-02.
2. Disable the 2048 and Snake menu buttons until those scenes do something, so no button
   opens an empty screen → BACKLOG GAME-02/03. Re-enabled by Milestones 7 and 8.
3. Verify a `0.2`-era save still loads under `0.3`.

**Done when:** there is exactly one high score implementation, and no enabled menu button
opens a blank screen.

## Milestone 11: Shippable

Not a game — what turns the collection into something another person can run. Was version
1.0 in the old roadmap.

1. Export presets for Windows and Linux, and a build that runs outside the editor.
2. Save migration from `0.3` onward, exercised against a real old save file.
3. Controls visible in-game — per-game help, or one shared controls screen.
4. Audio actually used; three notes sit unhooked in `resources/Audio + SFX/`.
5. Options: volume, fullscreen default (currently F11-only and not persisted), and a way
   to clear high scores.
6. A pass on screen bounds, so the games stop assuming 1152×648.

**Done when:** someone who does not have Godot installed can play the collection.

## Later — from the README wishlist

Parked. Each becomes its own milestone when it is started, not before.

**Beginner (1–2 weeks each)**
Memory Card Match · Tetris

**Intermediate (2–4 weeks each)**
Space Invaders / Galaga · Tower Defense · Tiny top-down RPG · Puzzle Platformer

**Advanced (months)**
Metroidvania-lite · Roguelike dungeon crawler · Isometric farming game

Also parked: Suika game.

These stay parked until Milestone 11. The shell has never carried more than a handful of
games at once, and the shared code (`GameState`, high scores, save) is where the strain
will show first — that is worth learning before adding a tower defense.

## Suggested work order

Milestone numbers record when a game entered the project. This is the order to actually
work on them:

**10 → 4 → 5 → 7 → 8 → 9 → 6 → 11**

- **Fix before add.** Milestone 10 comes first because it is entirely repairs. Every new
  game inherits the shared systems, so shipping Snake on top of a half-migrated high score
  panel just multiplies the bug.
- **Finish what's started next.** Speed Typing (4) and Flapper (5) are each a few tasks
  from done, and both already have their save keys in place.
- **Cheap games before expensive ones.** Snake (7) and 2048 (8) are days of work; the
  platformer (6) is months. Ordering the cheap ones first keeps the collection growing
  while the big piece waits.
- **The platformer late** because it is the only game needing new content pipelines
  (tilesets, level design) rather than just new code.
- **Shipping (11) last**, once there is nothing left that opens a dead end.
