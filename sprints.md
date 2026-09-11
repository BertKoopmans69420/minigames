# Sprints — Minigames

_Last updated: 2026-09-11 · Current sprint: 8_

The README numbers the work in sprints but lists them out of order. This document
reconstructs them from the git history and the README's own numbering, then plans
what comes next.

**A sprint here** is one themed chunk of work — usually one minigame or one shared
system — worked on until it is playable. There are no fixed dates; the numbering marks
sequence, not calendar time.

**Every sprint is a milestone.** Sprint _N_ is Milestone _N_ in `roadmap.md`, one for one.
This document is the work; the roadmap is what the work is for. Adding a sprint here means
adding the matching milestone there.

**A subsprint** is a small piece of work that isn't a game and isn't for the player —
tooling and quality-of-life things built for the author, alongside whatever sprint was
running at the time. They are numbered separately because they don't belong in the game
sequence, and they don't block a sprint from being called done. **Subsprints are not
milestones** — the one-for-one rule applies to numbered sprints only.

---

## Completed

### Sprint 1 — Pong
**Goal:** ship one complete game end to end.
**Delivered:** `Pong`, `PongBall`, `PongPlayer`; 1-player mode against a CPU paddle and
2-player hot-seat; first to 10 points wins; angle-of-reflection off the paddle with a
speed increase per hit; a shared button theme.
**Commits:** `a11b02e`, `39675b4`, `f86c5ef`, `aea700d`, `084d686`
**Learned:** `move_and_collide` collision response, `class_name` for type-checked
collision handling, and how much of a game is menus and win states rather than physics.

### Sprint 2 — Breakout
**Goal:** a game with entity variety and progression.
**Delivered:** `Breakout` with bricks, a mouse- or key-driven paddle, three lives, and
`level % 3` layout rotation from `breakout_levels.tscn`; eight powerups (laser, triple
balls, wide/short pad, slower/faster balls, safe floor, extra life) dropping from
destroyed bricks; brick strength colour-coding across twelve tiers; a flashing death
animation.
**Commits:** `88aa895`, `bd01afe`
**Learned:** timed entity effects, weighted random drops, marker-driven level layout,
and property setters that keep UI labels in sync.

### Sprint 3 — Top-down shooter
**Goal:** enemy waves and a difficulty curve.
**Delivered:** `Shooter` with twin-stick style movement, aimed bullets, chasing enemies
spawning from off-screen edges (never within 100 px of the player), and a spawn interval
that shrinks on every spawn; a millisecond survival timer with `set_time()` /
`set_time_s()` formatting.
**Commits:** `d07d80c`, `2c27851`
**Left open:** the commit message itself notes _"maybe add some powerups"_ → BACKLOG
FEAT-06.

### Sprint 4 — Speed Typing _(demo)_
**Goal:** a non-action game; text input and timing.
**Delivered:** `SpeedTyping` with a 26-sentence Hebrew corpus, HE/NL language toggle,
a running timer started by a dedicated input action, and per-language best times shown
on screen.
**Status:** playable demo. Records live in memory only, and the Dutch corpus was never
written (BACKLOG BUG-07). Reachable through a separate "typing practice" button rather
than the main game grid.

### Sprint 5 — Flapper _(incomplete)_
**Goal:** endless scrolling and procedural obstacles.
**Delivered:** `Flapper` with a parallax autoscrolling background, walls spawning every
2 s at randomised heights, and a gravity-plus-impulse player.
**Not delivered:** collision, scoring, game over, restart. `flapper_highscores` was
added to the save format in anticipation. → BACKLOG GAME-01.

### Sprint 6 — Pause menu
**Goal:** one shared system usable by every game.
**Delivered:** `PauseMenu` as a global overlay on the shell scene; `ESC` handled in the
`GameState` autoload with `PROCESS_MODE_ALWAYS` so input still arrives while the tree is
paused; a context-aware exit button reading "menu" inside a platformer level and "home"
otherwise.
**Learned:** `get_tree().paused` and process modes — the first thing in the project that
had to work across all games rather than inside one.

### Sprint 7 — High scores
**Goal:** persistence.
**Delivered:** three-letter name entry with automatic skip when the score cannot make
the table; a five-entry sorted table per game; JSON save/load at
`user://minigames.save` with `game_version` gating and per-key fallbacks so old saves
survive new games; and a first pass at a universal `HighScores` panel replacing the
per-game copies.
**Commits:** `4bd2ecc`, `032b0be`
**Left open:** the universal panel was written but the game scenes were never switched
over → BACKLOG BUG-02, BUG-03.

### Platformer, started — _now Sprint 12_
Work on the platformer began here, between Sprints 7 and 8, and was paused rather than
finished. It used to sit in this list unnumbered, which left it without a milestone. It is
now **Sprint 12**, below, so that both the started half and the remaining half live in one
sprint and one milestone. **Commits:** `5265914`, `9a47fcc`. → Sprint 12 / ROADMAP
Milestone 12.

---

## Subsprints

### Subsprint 1 — Line counter _(done)_
`line_counter.gd`, an `@tool EditorScript` run from **File → Run** in the editor. Walks
`res://`, skips `addons/`, and reports code lines, comment lines and total lines in an
`OS.alert()`. Nothing references it and nothing should — that is what a tool script is.
Currently reports ~1,750 lines across 21 scripts.

### Subsprint 2 — F11 fullscreen _(done)_
`minigames.gd::_input()` toggles between `MODE_EXCLUSIVE_FULLSCREEN` and
`MODE_WINDOWED`. Handled on the shell rather than in `GameState`, so it only responds on
the menu and inside games, never while something else has grabbed input.
Not persisted between runs — that belongs with an options screen (BACKLOG FEAT-03).

### Candidates for later subsprints
- A save-file inspector or "reset save" tool, for testing migrations without hunting
  down `user://minigames.save` by hand.
- A headless test script for the pure logic — `set_time()`, `equation_solution()`,
  `highscore_sort()` (PROC-01).

Export presets (FEAT-04) and the options screen (FEAT-03) used to be listed here. They are
player-facing rather than author tooling, so they moved into **Sprint 15 — Shippable**,
where they get a milestone of their own.

---

## Sprint 8 — Save system _(in progress)_

**Goal:** everything the player earns survives a restart.

Uncommitted work currently in the tree: the Flapper, Speed Typing, 2048 and Snake
folders; `math.gd` and `line_counter.gd`; new menu buttons and routing; the expanded
save format in `game_state.gd`; and the Flapper background/wall art.

| # | Task | Backlog ID | Size | |
| --- | --- | --- | --- | --- |
| 1 | Read `platformer_saves` back on load (was commented out) | BUG-04 | S | ✅ |
| 2 | Generalise `sort_highscores()` across all registered games | BUG-03 | S | ✅ |
| 3 | Persist Speed Typing records in the save file | — | S | |
| 4 | Commit the loose work: Flapper, Speed Typing, stubs, tools | — | S | |
| 5 | Verify a `0.2`-era save still loads under `0.3` | — | S | |

**Done when:** quitting and relaunching restores high scores, platformer progress and
typing records, and the working tree is clean.

---

## Sprint 9 — Shared systems cleanup _(planned)_

**Goal:** pay off the debt Sprint 7 left behind, before adding more games on top of it.

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

**Done when:** no menu button opens a blank screen and there is exactly one high score
implementation.

---

## Sprint 10 — Finish Flapper _(planned)_

**Goal:** turn the scrolling prototype into a game.

| # | Task | Backlog ID | Size |
| --- | --- | --- | --- |
| 1 | Wall and ground collision → death | GAME-01 | S |
| 2 | Score on wall passed, displayed live | GAME-01 | S |
| 3 | Game over → high score entry via the shared panel | GAME-01 | S |
| 4 | Restart and exit-to-menu from the game over screen | GAME-01 | S |
| 5 | Ceiling bound so the player cannot climb out of play | GAME-01 | S |

**Done when:** Flapper writes into `flapper_highscores` and can be replayed without
leaving the scene.

---

## Sprint 11 — Snake _(planned)_

Grid movement on a fixed cell size; growth on food pickup; self- and wall-collision;
score into the shared table; game over and restart. First entirely new game since
Sprint 5, and the warm-up for 2048's grid logic.

**Done when:** the Snake button leads to a game with a start, a fail state and a score.

---

## Sprint 12 — Platformer _(started, paused)_

**Goal:** world/level progression.

The half above, under _Completed_, is this sprint's first run: a world and level select
menu with correct button gating from `last_completed_world` / `last_completed_level`; a
`PlatformerPlayer` with gravity, jump and horizontal acceleration; the project's first
TileSet-based floor; level 1-1.

| # | Task | Backlog ID | Size |
| --- | --- | --- | --- |
| 1 | Levels 1-2 through 1-6 (World 1 complete) | — | L |
| 2 | Coins, lives and a death/respawn loop instead of exiting to the menu on a fall | — | M |
| 3 | Level completion writes `last_completed_world` / `last_completed_level` | — | S |
| 4 | Named save slots (`platformer_saves` is already keyed by player name) | — | M |
| 5 | Worlds 2 and 3, once World 1 proves the level pipeline | — | L |

Task 4 of Sprint 8 — reading `platformer_saves` back on load (BUG-04) — belongs to this
sprint's subject but was picked up there first, since it is a save-format fix.

The largest piece of unfinished work in the project.

**Done when:** a player can quit mid-progression and resume at the right level.

---

## Sprint 13 — 2048 _(planned)_

Tile grid with merge rules; spawn rules for new tiles; game over detection when no legal
move is left; score into the shared table. Reuses the grid thinking from Sprint 11. The
button is wired to an empty scene and `game_2048_highscores` is already in the save format.

**Done when:** the 2048 button leads to a game with a start, a fail state and a score.

---

## Sprint 14 — Math minigame _(planned)_

`math.gd` is written but has no scene and is not routed. Give it a scene and a menu route;
fix its dependency on the non-existent `GameState.in_menu`; and decide what it _is_ — a
standalone entry, or a gate mechanic inside the platformer. It emits an `open_gate` signal,
which suggests the latter; if so this sprint folds into Sprint 12 and the menu entry is
dropped.

**Done when:** the equations are reachable from somewhere, and `math.gd` no longer
references a property that does not exist.

---

## Sprint 15 — Shippable _(planned)_

Not a game — what turns the collection into something another person can run. Export
presets for Windows and Linux; save migration from `0.3` onward exercised against a real
old save; controls visible in-game; the three unhooked notes in `resources/Audio + SFX/`
actually used; an options screen (volume, fullscreen default, clear high scores); and a
pass on screen bounds so the games stop assuming 1152×648.

Several of these have been sitting in _Candidates for later subsprints_ — export presets
(FEAT-04) and the options screen (FEAT-03). They graduate to this sprint because shipping
is player-facing, not author tooling.

**Done when:** someone who does not have Godot installed can play the collection.

---

## Retrospective notes

Patterns worth keeping in mind when planning the next sprint:

- **Shared systems get built, then only half-adopted.** Both the universal high score
  panel (Sprint 7) and the platformer save format (Sprint 8) were written correctly and
  then left unwired. Adoption belongs *inside* the sprint that builds the abstraction,
  not in a follow-up.
- **Prototypes stall at the loss condition.** Flapper has scrolling, spawning and
  physics — everything except dying. That last 20% is what makes it a game.
- **Save-format keys land before the feature.** `flapper_highscores`,
  `game_2048_highscores` and `snake_highscores` were all added before their games
  existed. That is cheap and works well, since missing keys already fall back safely.
- **Sprints that ship a whole game (1, 2, 3) all completed.** Sprints split across
  several games (4, 5, 8) all left something open. Prefer one game per sprint.
