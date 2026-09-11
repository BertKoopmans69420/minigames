# Roadmap — Minigames

_Last updated: 2026-09-11 · Current version: 0.3 · Current milestone: 8_

The README lists the games in the order they happened to be written and ends with a note
to the author: _"(please order these)"_. This document is that ordering.

**Every sprint is a milestone.** Milestone _N_ is Sprint _N_ in `sprints.md`, one for one —
the sprint is the work, the milestone is what the work is _for_. A sprint is one themed
chunk: usually one minigame, sometimes one shared system. Milestones are numbered in the
order the sprints ran, not the order to work on them — for that, see _Suggested work order_
at the bottom.

This is a change from the previous roadmap, which used one milestone per _game_ and so did
not line up with the sprint numbering. Three consequences worth knowing:

- Shared-system work is no longer hidden in one catch-all milestone. The pause menu, high
  scores, the save system and the cleanup pass were four separate sprints, so they are now
  four separate milestones (6, 7, 8, 9).
- A game can span more than one milestone. Flapper is Milestone 5 (the prototype) and
  Milestone 10 (finishing it); the platformer is Milestone 12 for both halves.
- Speed Typing has no "remaining" milestone of its own. Sprint 4 shipped the demo and
  closed; persisting the records is task 3 of Sprint 8, and the Dutch corpus is BACKLOG
  BUG-07.

Status is written in the heading: `(Done)`, `(In Progress)`, or nothing for planned. Only
one milestone is In Progress at a time — it names the current focus.

**Subsprints are not milestones.** They are author tooling rather than player-facing work,
numbered separately in `sprints.md`, and they do not block a milestone from being called
done. The one-for-one rule applies to numbered sprints only.

## Where the project stands

| | Milestone | Sprint | Subject | State |
| --- | --- | --- | --- | --- |
| ✅ | 1 | 1 | Pong | Complete — 1P vs CPU, 2P, first to 10 |
| ✅ | 2 | 2 | Breakout | Complete — 3 rotating layouts, 8 powerups, lives, high scores |
| ✅ | 3 | 3 | Top-down Shooter | Complete — survival timer, ramping spawn rate, high scores |
| ✅ | 4 | 4 | Speed Typing | Closed as a demo — HE/NL toggle, records in memory only |
| ✅ | 5 | 5 | Flapper (prototype) | Closed incomplete — scrolling and spawning, no death |
| ✅ | 6 | 6 | Pause menu | Complete — global `ESC` overlay, context-aware exit |
| ✅ | 7 | 7 | High scores | Complete — name entry, sorted tables, JSON save |
| 🔨 | 8 | 8 | Save system | In progress — 2 of 5 tasks done |
| 🔨 | 9 | 9 | Shared systems cleanup | 6 of 8 tasks already ticked; 2 deletions left |
| ⬜ | 10 | 10 | Finish Flapper | Planned |
| ⬜ | 11 | 11 | Snake | Planned — empty scene, wired to a menu button |
| 🔨 | 12 | 12 | Platformer | Started then paused — only level 1-1 exists |
| ⬜ | 13 | 13 | 2048 | Planned — empty scene, wired to a menu button |
| ⬜ | 14 | 14 | Math minigame | Planned — script exists, no scene, not routed |
| ⬜ | 15 | 15 | Shippable | Planned — no export presets, no options, audio unhooked |

## Milestone 1: Pong (Done)

_Sprint 1._ The first game, and the one that proved a game could be finished end to end.

- 1-player mode against a CPU paddle, and 2-player hot-seat.
- First to 10 points wins.
- Angle-of-reflection off the paddle, with a speed increase per hit.
- The shared button theme every later game inherited.

**Done when:** _(met)_ both modes playable to a win state and back to the menu.

## Milestone 2: Breakout (Done)

_Sprint 2._ Entity variety and progression — the first game with content rather than just
rules.

- Bricks with twelve strength tiers, colour-coded.
- Mouse- or key-driven paddle, three lives, flashing death animation.
- Three rotating layouts via `level % 3` from `breakout_levels.tscn`.
- Eight powerups dropping from destroyed bricks: laser, triple balls, wide/short pad,
  slower/faster balls, safe floor, extra life.
- High scores.

**Done when:** _(met)_ layouts rotate, powerups drop and expire, scores persist.

## Milestone 3: Top-down Shooter (Done)

_Sprint 3._ Enemy waves and a difficulty curve.

- Twin-stick style movement with aimed bullets.
- Enemies chase the player, spawning from off-screen edges, never within 100 px.
- Spawn interval shrinks on every spawn.
- Millisecond survival timer with `set_time()` / `set_time_s()` formatting.
- High scores.

**Done when:** _(met)_ survival loop plays to a death and a score entry.

**Left open:** powerups, suggested by the commit message itself → BACKLOG FEAT-06. The
crash-on-continue and the high score panel migration belong to Milestone 9.

## Milestone 4: Speed Typing (Done)

_Sprint 4._ The first non-action game — text input and timing rather than physics. The
sprint shipped a demo and closed; what is missing was moved on rather than left open here.

**Delivered:** a 26-sentence Hebrew corpus, HE/NL language toggle, a timer started by a
dedicated input action, per-language best times shown on screen.

**Moved on, not dropped:**

1. Persisting the records is **task 3 of Milestone 8** — best times live in memory only
   and vanish on quit, and the save file is that milestone's subject.
2. The Dutch corpus behind the NL toggle → BACKLOG BUG-07.
3. Where it lives in the menu — it is reached through a separate "typing practice" button
   rather than the main game grid → open question, no milestone yet.

**Done when:** _(met)_ a sentence can be typed against a timer in at least one language.

## Milestone 5: Flapper, prototype (Done)

_Sprint 5._ Endless scrolling and procedural obstacles. The sprint closed incomplete — it
has everything except dying — and the rest became its own sprint rather than sitting here
unfinished. See Milestone 10.

**Delivered:** parallax autoscrolling background, walls spawning every 2 s at randomised
heights, gravity-plus-impulse player. `flapper_highscores` was added to the save format in
anticipation.

**Done when:** _(met)_ the background scrolls and walls spawn at randomised heights.

## Milestone 6: Pause menu (Done)

_Sprint 6._ The first shared system — code that had to work across all games rather than
inside one.

- `PauseMenu` as a global overlay on the shell scene.
- `ESC` handled in the `GameState` autoload with `PROCESS_MODE_ALWAYS`, so input still
  arrives while the tree is paused.
- A context-aware exit button reading "menu" inside a platformer level and "home"
  otherwise.

**Done when:** _(met)_ `ESC` pauses and resumes from inside any game.

## Milestone 7: High scores (Done)

_Sprint 7._ Persistence.

- Three-letter name entry, with automatic skip when the score cannot make the table.
- A five-entry sorted table per game.
- JSON save/load at `user://minigames.save`, with `game_version` gating and per-key
  fallbacks so old saves survive new games.
- A first pass at a universal `HighScores` panel replacing the per-game copies.

**Done when:** _(met)_ a score entered in Breakout is still on the table after a restart.

**Left open:** the universal panel was written but the game scenes were never switched
over → BACKLOG BUG-02, BUG-03, and Milestone 9.

## Milestone 8: Save system (In Progress)

_Sprint 8._ Everything the player earns survives a restart. This is the current focus.

| # | Task | Backlog ID | Size | |
| --- | --- | --- | --- | --- |
| 1 | Read `platformer_saves` back on load (was commented out) | BUG-04 | S | ✅ |
| 2 | Generalise `sort_highscores()` across all registered games | BUG-03 | S | ✅ |
| 3 | Persist Speed Typing records in the save file | — | S | |
| 4 | Commit the loose work: Flapper, Speed Typing, stubs, tools | — | S | |
| 5 | Verify a `0.2`-era save still loads under `0.3` | — | S | |

Uncommitted work still in the tree: the Flapper, Speed Typing, 2048 and Snake folders;
`math.gd` and `line_counter.gd`; new menu buttons and routing; the expanded save format in
`game_state.gd`; and the Flapper background/wall art.

**Done when:** quitting and relaunching restores high scores, platformer progress and
typing records, and the working tree is clean.

## Milestone 9: Shared systems cleanup

_Sprint 9._ Pay off the debt Milestone 7 left behind, before adding more games on top of
it. Six of the eight tasks are already ticked in `sprints.md` even though the sprint is
still marked planned — what is genuinely left is the two deletions.

| # | Task | Backlog ID | Size | |
| --- | --- | --- | --- | --- |
| 1 | Switch Breakout and Shooter to the universal `HighScores` panel | BUG-02 | M | ✅ |
| 2 | Call `set_game()` and fix Shooter's `$Shooter/High_Scores` path | BUG-02 | S | ✅ |
| 3 | Make "Continue" restart the game again in both panels | BUG-02 | S | ✅ |
| 4 | Fix Shooter's Continue reaching into Breakout's bricks | BUG-01 | S | ✅ |
| 5 | Guard `ESC` so it does nothing on the main menu | BUG-08 | S | ✅ |
| 6 | Fix the Speed Typing off-by-one sentence draw | BUG-05 | S | ✅ |
| 7 | Delete `breakout_high_scores.gd/.tscn` and `shooter_high_scores.gd/.tscn` | BUG-02 | S | |
| 8 | Disable the 2048 and Snake buttons until those scenes exist | GAME-02/03 | S | |

Task 8 is re-opened by Milestones 11 and 13, which is when those buttons should lead
somewhere.

**Done when:** there is exactly one high score implementation, and no enabled menu button
opens a blank screen.

## Milestone 10: Finish Flapper

_Sprint 10._ Turn the Milestone 5 prototype into a game. All of it is BACKLOG GAME-01.

| # | Task | Backlog ID | Size |
| --- | --- | --- | --- |
| 1 | Wall and ground collision → death | GAME-01 | S |
| 2 | Score on wall passed, displayed live | GAME-01 | S |
| 3 | Game over → high score entry via the shared panel | GAME-01 | S |
| 4 | Restart and exit-to-menu from the game over screen | GAME-01 | S |
| 5 | Ceiling bound so the player cannot climb out of play | GAME-01 | S |

**Done when:** Flapper writes into `flapper_highscores` — already plumbed through the save
file in anticipation — and can be replayed without leaving the scene.

## Milestone 11: Snake

_Sprint 11._ Grid movement, growth, self-collision. The simplest remaining game and the
natural warm-up for 2048's grid logic. First entirely new game since Milestone 5.

1. Grid movement on a fixed cell size.
2. Growth on food pickup.
3. Self- and wall-collision → game over.
4. Score into the shared high score table.
5. Restart from the game over screen.

Until this lands the menu button opens an empty scene — disable it (Milestone 9, task 8)
rather than leave a dead end. `snake_highscores` already exists in the save format.

**Done when:** the Snake button leads to a game with a start, a fail state and a score.

## Milestone 12: Platformer

_Sprint 12._ The biggest single piece of remaining work, and the reason the save format
already carries worlds, lives, coins and per-player rows. The sprint was started between
Sprints 7 and 8, paused, and is numbered 12 so both halves sit in one milestone.

**Delivered:** world and level select with button gating from `last_completed_world` /
`last_completed_level`; a `PlatformerPlayer` with gravity, jump and horizontal
acceleration; the project's first TileSet-based floor; level 1-1.

**Remaining:**

1. Levels 1-2 through 1-6 (World 1 complete).
2. Coins, lives and a real death/respawn loop instead of returning to the menu on a fall.
3. Level completion writes `last_completed_world` / `last_completed_level` into the save.
4. Read `platformer_saves` back on load — the write side works, the read was left
   commented out → BACKLOG BUG-04. _(Also Milestone 8, task 1; done there first.)_
5. Named save slots; `platformer_saves` is already keyed by player name.
6. Worlds 2 and 3, once World 1 proves the level pipeline.

**Done when:** a player can quit mid-progression and resume at the right level.

## Milestone 13: 2048

_Sprint 13._ Reuses the grid thinking from Milestone 11.

1. Tile grid with merge rules.
2. Spawn rules for new tiles.
3. Game over detection (no legal move).
4. Score into the shared table.

Same as Snake: the button is wired to an empty scene, and `game_2048_highscores` is
already in the save format.

**Done when:** the 2048 button leads to a game with a start, a fail state and a score.

## Milestone 14: Math minigame

_Sprint 14._ `math.gd` is written but has no scene and is not routed.

1. Give it a scene and a menu route.
2. Fix its dependency on the non-existent `GameState.in_menu`.
3. Decide what it _is_ — a standalone entry, or a gate mechanic inside the platformer. It
   emits an `open_gate` signal, which suggests the latter; if so this milestone folds into
   Milestone 12 and the entry is dropped from the menu.

**Done when:** the equations are reachable from somewhere, and `math.gd` no longer
references a property that does not exist.

## Milestone 15: Shippable

_Sprint 15._ Not a game — what turns the collection into something another person can run.
Was version 1.0 in the old roadmap.

1. Export presets for Windows and Linux, and a build that runs outside the editor.
2. Save migration from `0.3` onward, exercised against a real old save file.
3. Controls visible in-game — per-game help, or one shared controls screen.
4. Audio actually used; three notes sit unhooked in `resources/Audio + SFX/`.
5. Options: volume, fullscreen default (currently F11-only and not persisted), and a way
   to clear high scores.
6. A pass on screen bounds, so the games stop assuming 1152×648.

**Done when:** someone who does not have Godot installed can play the collection.

## Later — from the README wishlist

Parked. Each becomes its own sprint, and so its own milestone, when it is started — not
before.

**Beginner (1–2 weeks each)**
Memory Card Match · Tetris

**Intermediate (2–4 weeks each)**
Space Invaders / Galaga · Tower Defense · Tiny top-down RPG · Puzzle Platformer

**Advanced (months)**
Metroidvania-lite · Roguelike dungeon crawler · Isometric farming game

Also parked: Suika game.

These stay parked until Milestone 15. The shell has never carried more than a handful of
games at once, and the shared code (`GameState`, high scores, save) is where the strain
will show first — that is worth learning before adding a tower defense.

## Suggested work order

Milestone numbers record the order the sprints ran. This is the order to actually work on
what is left:

**8 → 9 → 10 → 11 → 13 → 14 → 12 → 15**

- **Finish the sprint that is open.** Milestone 8 is the current focus and three tasks from
  done, one of which (persisting typing records) is the last thing Speed Typing needs.
- **Fix before add.** Milestone 9 is entirely repairs. Every new game inherits the shared
  systems, so shipping Snake on top of a half-migrated high score panel just multiplies the
  bug.
- **Finish what's started next.** Flapper (10) is five small tasks and already has its save
  key in place.
- **Cheap games before expensive ones.** Snake (11), 2048 (13) and the math minigame (14)
  are days of work each; the platformer (12) is months. Ordering the cheap ones first keeps
  the collection growing while the big piece waits.
- **The platformer late** because it is the only game needing new content pipelines
  (tilesets, level design) rather than just new code.
- **Shipping (15) last**, once there is nothing left that opens a dead end.

Note that the ordering is nearly sequential now. Under the old game-based numbering the
order was 10 → 4 → 5 → 7 → 8 → 9 → 6 → 11, which read as arbitrary; sprint numbering makes
the two out-of-order entries (12 and 14) the exceptions they actually are.
