# Changelog — Minigames

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project uses the
save-format version in `game/game_state.gd` (`const game_version`) as its version
number.

History before this file was written has been reconstructed from the git log; the
version boundaries below are inferred from the work, not from tags — no releases have
been tagged yet.

---

## [Unreleased]

Work sitting in the working tree, not yet committed as of 2026-09-01.

### Added
- **Flapper minigame** (`game/flapper/`) — parallax autoscrolling background, walls
  spawning every 2 s at randomised heights, and a gravity-plus-flap player. No loss
  condition yet.
- **Speed Typing minigame** (`game/speed_typing/`) — 26-sentence Hebrew corpus, HE/NL
  toggle, run timer on a dedicated input action, and per-language best times. Records
  are held in memory only.
- **2048 and Snake scene stubs** (`game/2048/2048.tscn`, `game/snake/snake.tscn`) —
  empty `Node2D`s, already routed from the menu.
- **Math minigame script** (`math.gd`) — 14 difficulty levels across `+ - * / ^`, ten
  questions per run, answer-as-you-type checking, and an `open_gate` signal. No scene
  and not routed yet.
- **Line counter tool** (`line_counter.gd`) — an `@tool EditorScript` that walks
  `res://` and reports code, comment and total line counts.
- **Menu entries** for Flapper, 2048, Snake and a separate "typing practice" button.
- **Input actions**: `Flapper jump`, `Speed Typing start timer`, `F11` fullscreen.
- **Flapper art**: `Flapper_background.png`, `Flapper_wall.png`.

### Changed
- **Save format extended** to carry `flapper_highscores`, `game_2048_highscores`,
  `snake_highscores` and `platformer_saves` alongside the existing tables. Each key
  falls back to an empty five-entry table when absent, so older saves still load.
- **`GameState.scenes`** now registers `flapper`, `2048`, `snake` and `speed_typing`.
- Fullscreen toggling moved onto `minigames.gd::_input()`.
- Breakout scene and script adjustments; `resources/tres/pixel_text.tres` tweak.
- README expanded with the sprint numbering and the long-term game wishlist.

- **Breakout and Shooter switched to the universal `HighScores` panel**; both scenes now
  instance `high_scores.tscn` instead of their own copies.

### Fixed
_All changed lines are tagged with a `#changed` comment._

- **Game over no longer crashes in Breakout or Shooter.** `HighScores.set_game()` was
  never called by anything, leaving the panel with no game and no score array. Both
  games now call it in `show_high_scores()`.
- **Shooter's high score panel path was wrong** — `$Shooter/High_Scores` resolved to
  nothing, because the scene root is itself named `Shooter`. Now `$High_Scores`.
- **"Continue" works again.** The visibility resets and the restart call had ended up
  inside the Breakout-only branch of `HighScores._on_continue_pressed()`, so Continue
  did nothing in the Shooter and never restarted either game.
- **"Continue" now clears the whole Breakout board.** The loop freed
  `bricks.get_child(0)` on every pass, but `queue_free()` is deferred to the end of the
  frame, so it kept picking the same brick — one brick removed, the rest left standing
  under the newly spawned level.
- **Platformer progress is read back on load.** `platformer_saves` was written to the
  save file but its load line was commented out, discarding progress every restart.
- **All high score tables are sorted and trimmed**, not just Breakout and Shooter. The
  Flapper, 2048 and Snake tables would otherwise have grown without bound.
- **`ESC` no longer opens the pause menu on the main menu** when no game is running.
- **Speed Typing no longer picks an out-of-range sentence** — `randi_range` is inclusive
  at both ends, so the top draw indexed one past the end of the list.
- **Dutch mode has sentences.** `_on_nl_pressed()` switched the label without ever
  setting text, so NL always showed the alphabet placeholder.
- **`GameState.in_menu` now exists**, which `math.gd` reads and writes.

### Known issues
- The 2048 and Snake buttons open blank screens.
- `breakout_high_scores.gd/.tscn` and `shooter_high_scores.gd/.tscn` are now unused and
  can be deleted.
- `math.gd` still has no scene and is not routed from the menu.

---

## [0.3] — High scores go universal

_Commit `032b0be`, "made highscores universal, not one per game"._

### Added
- `game/high_scores.gd` (`class_name HighScores`) — a game-agnostic high score panel
  with `set_game()`, `enter_name()` and score formatting that switches between points
  and elapsed time.

### Changed
- Save-format version raised to `0.3`.

### Known issues
- The new panel is not yet used by any scene; `breakout_high_scores.gd` and
  `shooter_high_scores.gd` remain in place.
- `sort_highscores()` still names only Breakout and Shooter.

---

## [0.2] — Shooter

_Commits `d07d80c` ("Shooter added. Working, bat maybe add some powerups"), `2c27851`._

### Added
- **Top-down shooter minigame** (`game/shooter/`): eight-direction movement with the
  player sprite facing the movement direction, aimed bullets that despawn off-screen,
  and chasing enemies that kill on contact.
- Enemies spawn from a random screen edge, rejected if within 100 px of the player.
- Difficulty ramp: the spawn interval shrinks on every spawn from a 3.0 s start.
- A millisecond survival timer with `set_time()` / `set_time_s()` formatting, and a
  Shooter high score table keyed on survival time.
- Input actions: `Shooter left/right/up/down`, `Shooter shoot`.

---

## [0.1] — Platformer started, high scores, Breakout, Pong

### Added

**Platformer** — commits `5265914`, `9a47fcc`
- World and level select menu with button gating driven by
  `last_completed_world` / `last_completed_level`.
- `PlatformerPlayer` with gravity, jump and horizontal acceleration.
- The project's first TileSet-based floor, and level `1-1`.
- Input actions: `Platformer left/right/jump`.

**High scores and saving** — commit `4bd2ecc`
- Three-letter name entry, automatically skipped when the score cannot make the table.
- Five-entry sorted tables, trimmed by `sort_highscores()`.
- JSON persistence to `user://minigames.save`, gated on a `game_version` key, written on
  boot and after every score entry.

**Breakout** — commits `88aa895`, `bd01afe`
- Bricks with strength tiers 1–12 and colour coding per tier; a flashing death animation.
- Paddle controlled by mouse or keys; three starting lives; ball speed scaling with level.
- Level layouts from `breakout_levels.tscn` markers, cycling every three levels with
  brick strength climbing.
- Eight powerups: laser, triple balls, wide pad, short pad, slower balls, faster balls,
  safe floor (three hits) and extra life — weighted so extra life is rare.
- Input actions: `Breakout left`, `Breakout right`.

**Pong** — commits `a11b02e`, `39675b4`, `f86c5ef`, `aea700d`, `084d686`
- The first minigame: 2-player hot-seat and 1-player versus a CPU paddle.
- Angle-of-reflection off the paddle, widening near the paddle edges, with a speed
  increase on every hit.
- First to 10 points wins, with per-mode win screens.
- Shared button theme and pixel font styling.
- Input actions: `Pong up/down 1`, `Pong up/down 2`.

**Application shell** — commit `a11b02e` onward
- `game/minigames.tscn` main menu with a `Games` container that holds exactly one
  running minigame.
- The `GameState` autoload: scene routing via `enter()` / `exit()`, global references,
  and global `ESC` handling.
- `PauseMenu` overlay with a context-aware exit label, kept responsive while the tree is
  paused via `PROCESS_MODE_ALWAYS`.
- Godot 4.6 project configured at 1152×648 with `canvas_items` stretch.

---

## Maintaining this file

- Add to **[Unreleased]** as work lands, under `Added` / `Changed` / `Fixed` /
  `Removed`.
- When `const game_version` in `game/game_state.gd` is bumped, rename `[Unreleased]` to
  that version, date it, and tag the commit (`git tag v0.4`).
- Bump the version whenever the **save format** changes, since that is what the number
  actually gates.
- Write entries for a player, not a compiler: what changed in the game, not which
  function moved.
