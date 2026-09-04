# Backlog — Minigames

_Last updated: 2026-09-01 · Version: 0.3_

Every item below was derived from reading the current source. File and line references
point at the code as of this date.

Items marked **✅ FIXED** have been repaired in the working tree; the changed lines are
tagged with a `#changed` comment so they are easy to find, review or revert.

**Priority:** P0 crash or data loss · P1 blocks a milestone · P2 real improvement ·
P3 nice to have
**Size:** S ≈ an evening · M ≈ a few sessions · L ≈ a sprint or more

---

## Bugs

### BUG-01 · P0 · S · ✅ FIXED · Shooter "Continue" reached into Breakout
`game/shooter/shooter_high_scores.gd:46` — `_on_continue_pressed()` looped over
`GameState.breakout.bricks.get_children()`, a copy-paste artefact from
`breakout_high_scores.gd`. Now commented out. Note this file is **no longer used** —
see BUG-02 — so it is safe to delete along with `shooter_high_scores.tscn`.

### BUG-02 · P1 · M · ✅ MOSTLY DONE · Universal high score panel migration
Commit `032b0be` added `game/high_scores.gd` (`class_name HighScores`). Both
`breakout.tscn` and `shooter.tscn` now instance `high_scores.tscn`, so the migration is
done at the scene level. Two problems this left, both now fixed:

- **`set_game()` was never called by anyone.** Without it, `HighScores.game` is `null`
  and `HighScores.highscores` is empty, so `show_scores()` throws on game over. Now
  called at the top of each game's `show_high_scores()`.
- **`shooter.gd` used the wrong node path** — `$Shooter/High_Scores` instead of
  `$High_Scores`. The root node *is* `Shooter`, so that path resolved to nothing.
- **`_on_continue_pressed()` restarted nothing.** The visibility resets and the restart
  call sat inside the `if game == GameState.breakout` block, so Continue did nothing at
  all in the Shooter, and never re-ran `_ready()` in either game. Dedented, and
  `game._ready()` restored.

**Still open:** delete the now-unused `breakout_high_scores.gd/.tscn` and
`shooter_high_scores.gd/.tscn`.

### BUG-03 · P1 · S · ✅ FIXED · `sort_highscores()` only handled two games
Sorted and trimmed `breakout_highscores` and `shooter_highscores` only, so
`flapper_highscores`, `game_2048_highscores` and `snake_highscores` would have grown
without bound. Now a `for` loop over all five arrays; the old function is kept
commented out above it. Add new games to that list.

### BUG-04 · P0 · S · ✅ FIXED · Platformer progress was saved but never loaded
`GameState.platformer_saves = save_data["platformer_saves"]` was commented out in
`load_from_file()` while `save_to_file()` still wrote the key, so progress was discarded
on every restart. Now read back behind a `has()` guard, matching the pattern used by the
highscore keys.

### BUG-05 · P1 · S · ✅ FIXED · Speed Typing could pick an out-of-range sentence
`hebrew_list[randi_range(0, len(hebrew_list))]` — `randi_range` is inclusive at both
ends, so the top draw indexed one past the end and threw. Now `len(hebrew_list) - 1`.

### BUG-06 · P1 · S · ✅ FIXED · `math.gd` used a `GameState` property that did not exist
`math.gd:34` and `math.gd:175` read and write `GameState.in_menu`. The property is now
declared on the singleton. `math.gd` still has no scene and is not routed — see GAME-04.

### BUG-07 · P2 · S · ✅ FIXED · Dutch sentence list was missing
`_on_nl_pressed()` switched the visible label without ever setting new text, so NL mode
always showed the alphabet placeholder baked into the scene. A `dutch_list` mirroring
`hebrew_list` has been added and is drawn from on language switch. The sentences are a
starting set — swap them for whatever you actually want to practise.

### BUG-08 · P2 · S · ✅ FIXED · `ESC` opened the pause menu on the main menu
`_input()` toggled pause and the overlay on any `ESC`, including on the main menu with
no game running. Now returns early when `MINIGAMES.games` has no children.

### BUG-09 · P2 · S · Breakout can advance a level during the brick death animation
`game/breakout/breakout.gd:33` advances the level whenever `$Bricks.get_children()` is
empty, but `breakout_brick.gd::die()` keeps the node alive for ~0.5 s of flashing.
The check is correct today only because the dying brick is still a child; it is fragile
and worth making explicit with a live-brick counter.

### BUG-11 · P1 · S · ✅ FIXED · "Continue" only removed one Breakout brick
`game/high_scores.gd:70` — the loop called
`GameState.breakout.bricks.get_child(0).queue_free()` on every pass. `queue_free()` is
deferred until the end of the frame, so the node stays in the tree and `get_child(0)`
returns the *same* brick every time: one brick freed, N times over, and the rest of the
old board left standing while `_ready()` spawned a fresh level on top of it. Now frees
the loop variable, `i.queue_free()`.

The same line exists in the orphaned `breakout_high_scores.gd:46` — it goes away when
that file is deleted (BUG-02).

### BUG-10 · P3 · S · ✅ FIXED · Unused parameter in Speed Typing
`_on_line_edit_text_submitted(new_text)` ignored `new_text` and re-read `lineedit.text`.
Renamed to `_new_text` to silence the warning.

---

## Unfinished games

### GAME-01 · P1 · M · Flapper has no loss condition
`game/flapper/flapper.gd` spawns walls and scrolls the parallax background; there is no
collision handling on `FlapperPlayer`, no score, no game over, no restart, and no
ceiling/floor bound. `flapper_highscores` already exists in the save file, waiting.

### GAME-02 · P1 · M · Snake is an empty scene
`game/snake/snake.tscn` is a bare `Node2D`, yet the menu button routes to it — pressing
SNAKE produces a blank screen escapable only with `ESC`. Build it or disable the button.

### GAME-03 · P1 · M · 2048 is an empty scene
Same as GAME-02 for `game/2048/2048.tscn`.

### GAME-04 · P2 · M · Math minigame is unrouted
`math.gd` implements 14 difficulty levels, question tracking and an `open_gate` signal,
but has no `.tscn`, no entry in `GameState.scenes`, and no menu button. Decide whether
it is a standalone minigame or a platformer gate mechanic (the signal suggests the
latter), then wire it up.

### GAME-05 · P2 · L · Platformer has one level
`game/platformer/levels/` contains only `1-1.tscn`; levels 1-2 … 8-6 are commented out
in `platformer.gd`. The level buttons are correctly disabled, so this is missing
content rather than a bug — but `play_level()` would fail on a missing dictionary key if
a button were ever enabled early.

### GAME-06 · P2 · S · Platformer death returns to the menu
`platformer_player.gd` calls `GameState.platformer.to_menu()` when the player falls off
the bottom. There is no life loss, no respawn and no death feedback, despite `lives`
existing on `Platformer`.

### GAME-07 · P3 · S · Pong has no high scores
Pong is the only finished game with no persistent record. A "longest rally" or
"wins vs CPU" counter would fit the existing table.

---

## Architecture and code health

### ARCH-01 · P2 · M · Entities depend on the `GameState` singleton
`BreakoutBall` reads `GameState.breakout.player`, `ShooterEnemy` reads
`GameState.shooter.player`, `BreakoutBrick` writes `GameState.breakout.points`. Scenes
cannot be run standalone (F6) and a second instance of a game would break. Pass a
reference on instantiation, or use `get_parent()` / an exported node path.

### ARCH-02 · P2 · S · Screen bounds are magic numbers
`1152`, `648`, `1160`, `656`, `1152-56`, `648-32` are scattered across
`pong_player.gd`, `breakout_player.gd`, `breakout_ball.gd`, `shooter.gd`,
`shooter_bullet.gd` and `flapper.gd`. Centralise as constants or read the viewport.

### ARCH-03 · P3 · S · Loose scripts at the repository root
`math.gd` and `line_counter.gd` sit beside `project.godot`. Move to `game/math/` and
`tools/` respectively.

### ARCH-04 · P3 · S · `drop_powerup()` weights via a 21-arm `match`
`breakout_brick.gd` implements powerup weighting as a hand-written `match` over
`randi_range(1, 21)` with repeated arms. A weight table (`{"laser": 3, "extra life": 1,
…}`) expresses the same distribution and makes tuning a one-line change.

### ARCH-05 · P3 · S · Dead code in `game_state.gd`
Roughly 35 blank lines (lines 78–101) sit between `highscore_sort()` and
`load_save_file()`, alongside a commented-out `save()` call in `_ready()`.

### ARCH-06 · P3 · S · Version constant lives only in code
`const game_version = "0.3"` in `game_state.gd` is the sole source of truth;
`project.godot` has no `config/version`. They should agree, with one being derived.

---

## Polish and features

### FEAT-01 · P2 · S · Audio is imported but unused
`resources/Audio + SFX/` holds `a2.mp3`, `a4.mp3` and `f#4.mp3` with import files, and
nothing plays them. Pong and Breakout paddle hits are the obvious first users.

### FEAT-02 · P2 · M · No in-game controls display
Each game uses a different key set (`Pong up 1`, `Breakout left`, `Shooter shoot`,
`Flapper jump`, `Speed Typing start timer`) and none of them is shown to the player.

### FEAT-03 · P2 · S · No options screen
No volume control, no fullscreen preference (only the `F11` toggle, which is not
persisted), no way to clear high scores.

### FEAT-04 · P2 · M · No export presets
`project.godot` has no `[preset]` sections, so there is no reproducible build for
Windows or Linux and no way to play outside the editor.

### FEAT-05 · P3 · M · Breakout level layouts repeat every three levels
`set_level()` uses `level % 3` against the three marker groups in
`breakout_levels.tscn`. Difficulty climbs via brick strength, but the shapes recycle
quickly. More layouts, or generated ones.

### FEAT-06 · P3 · S · Shooter enemies never shoot
`ShooterEnemy` only chases and kills on contact. A ranged enemy type would make the
survival timer more interesting, and the README already notes "maybe add some powerups"
for the shooter (commit `d07d80c`).

### FEAT-07 · P3 · S · High score table is capped at five entries
`sort_highscores()` trims to five. A longer table, or per-game table lengths, once the
generic panel from BUG-02 exists.

---

## Process

### PROC-01 · P2 · M · No automated tests
Verification is manual play-testing. Pure logic — `Shooter.set_time()`,
`Math.equation_solution()`, `GameState.highscore_sort()`, save round-tripping — is
testable with GUT or a headless script and is where regressions will hide.

### PROC-02 · P3 · S · README doubles as roadmap, backlog and design doc
Now superseded by this folder. Trim the README to what a newcomer needs (what it is,
how to run it, controls) and let it link here.

### PROC-03 · P3 · S · All work happens directly on `master`
Thirteen commits, one branch, no tags. Tagging releases (`v0.3`) would give the
changelog real anchors.
