# Vision — Minigames

_Last updated: 2026-09-01 · Project version: 0.3_

## One line

A single desktop application that collects small, self-contained arcade games, built
from scratch in Godot as a way of learning game programming end to end.

## Why this project exists

The README states the intent plainly: _"This is a game I made to try coding games by
myself."_ Every mechanic in the repository — ball physics, powerup drops, enemy
spawning, save files, high score entry — is hand-written rather than pulled from an
asset store or a tutorial template. The point is not to ship a commercial product; the
point is that each minigame teaches a distinct, transferable technique:

| Game | What it exists to teach |
| --- | --- |
| Pong | Collision response, angle-of-reflection maths, a simple CPU opponent |
| Breakout | Level data, entity lifecycles, powerups, lives, score persistence |
| Shooter | Enemy spawning, difficulty ramping over time, aiming and projectiles |
| Platformer | Tilemaps, gravity/jump feel, world/level progression and save slots |
| Flapper | Endless scrolling, parallax backgrounds, procedural obstacle spawning |
| Speed Typing | Text input handling, timers, multi-language (Hebrew/Dutch) UI |
| 2048 / Snake | Grid-based state, self-collision, tile merging |

## Who it is for

1. **The author, first.** The project is a personal curriculum. A feature is "worth
   doing" primarily if it teaches something not yet learned.
2. **Friends and family playing locally.** The shared high score table and the 2-player
   Pong mode exist because the games get played on one machine, side by side.

## Design principles

- **One shell, many games.** A single main menu (`game/minigames.tscn`) launches every
  minigame into the same `Games` node and tears it down on exit. New games plug into
  that shell rather than becoming separate projects.
- **Shared services, not copied code.** Pausing, saving, high scores and scene
  switching live once in the `GameState` autoload. When two games need the same thing,
  the answer is to generalise it — as was done in commit `032b0be`,
  _"made highscores universal, not one per game"_.
- **Small games, finished games.** Each minigame should reach a playable end state
  (a win condition, a game over, a score) before the next one starts. Prototypes are
  allowed to sit unfinished, but the roadmap tracks them honestly.
- **Pixel-art, keyboard-and-mouse, 1152×648.** All games share one visual language
  (`resources/tres/pixel_text.tres`, the `Robot Crush` font, the pixel sprite set) and
  one window size, so the shell never has to reconfigure the viewport.
- **Everything the player earns survives.** Scores and progress belong in
  `user://minigames.save`, versioned so old saves can be migrated rather than lost.

## What success looks like

- **v1.0** — Seven or more minigames, each with a start state, a fail state and a score
  or completion condition; a working pause menu everywhere; a save file that survives
  version changes; an exported build that runs on another machine without the editor.
- Someone who has never seen the project can open the menu, pick anything, understand
  the controls within a few seconds, and get back to the menu without getting stuck.

## Explicit non-goals

- No multiplayer over a network. Local hot-seat only.
- No monetisation, telemetry or accounts.
- No mobile or console ports — desktop (Windows/Linux) with keyboard and mouse.
- No third-party gameplay frameworks. Learning is the deliverable, so gameplay code
  gets written by hand even when a plugin would be faster.
- Not a level editor, a modding platform, or an engine.

## The long horizon

The README already sketches life after the arcade collection: Memory Match, Tetris,
Space Invaders, a tower defense, a tiny top-down RPG, and eventually a Metroidvania or
roguelike. Those are deliberately parked. They become relevant once the current shell
proves it can carry seven games without the shared code buckling — that is the real
test this project is running.
