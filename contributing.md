# Contributing — Minigames

_Last updated: 2026-09-01_

This is a personal learning project (see `vision.md`), so "contributing" mostly means
_"how the author works, written down"_ — and how to keep new code consistent with the
1,750 lines already here.

---

## Getting set up

1. **Godot 4.6** (Forward Plus). The project declares
   `config/features = PackedStringArray("4.6", "Forward Plus")`; an older editor will
   refuse to open it, and a newer one will silently upgrade the file.
2. Clone the repository and open `project.godot` from the Godot project manager.
3. Press **F5** to run. `game/minigames.tscn` is the main scene and you land on the
   game menu.

No build step, no package manager, no addons.

**Note:** individual game scenes generally cannot be run standalone with **F6**. Entities
reach their game through the `GameState` singleton (`GameState.breakout.player`), which
is only populated once the game has been entered from the menu.

## Repository layout

See `architecture.md` §2 for the full tree. The short version:

- `game/<name>/` — one folder per minigame, containing its root scene, its script, and
  one script per entity type.
- `game/game_state.gd` — the `GameState` autoload; shared state and routing.
- `resources/` — art, fonts, audio and themes, shared across every game.
- `AI Files/` — this documentation.
- `.godot/` — engine cache, git-ignored. Never commit it.

## Coding conventions

These are observed from the existing code — match them.

**Naming**

- Files: `snake_case.gd` / `snake_case.tscn`, prefixed with the game name for entities —
  `breakout_ball.gd`, `shooter_enemy.gd`, `flapper_wall.gd`.
- Classes: `class_name PascalCase extends <NodeType>` on essentially every script. This
  is what makes `if collider is BreakoutBrick` work, so do not skip it.
- Input actions: `"<Game> <action>"` — `"Breakout left"`, `"Shooter shoot"`,
  `"Flapper jump"`. Global actions are bare: `ESC`, `F11`, `up`, `down`.
- High score arrays on `GameState`: `<game>_highscores`.

**Style**

- Tabs for indentation (Godot default). `.editorconfig` pins UTF-8; `.gitattributes`
  normalises line endings to LF.
- Node access: `@onready var player = $Shooter_Player` for anything used repeatedly,
  `$Path/To/Node` inline for one-offs.
- Signal handlers are named `_on_<node>_<signal>()` and connected in the editor, not in
  code — that is how the whole project wires its UI.
- Unused parameters get a leading underscore: `func _process(_delta):`.
- Prefer property setters over manual UI refreshes, following `breakout.gd`:

  ```gdscript
  var points:int:
      set(value):
          points = value
          $Points.text = str(value, "P")
  ```

- Type hints where they help (`var speed:float = 150`), untyped where the code reads
  fine without. The existing code is inconsistent here; new code should lean typed.

**Comments**

Sparse and only where the logic is non-obvious. If a comment is AI- or tutorial-derived
and has not been verified, say so — `math.gd` does exactly this with
`#AI DOCUMENTATION, NOT CHECKED`, which is a good habit worth keeping.

---

## Adding a new minigame

Six steps, following the pattern every existing game uses. Snake is the worked example.

**1. Create the folder and root scene**

`game/snake/snake.tscn` with a `Node2D` root named after the game.

**2. Write the root script**

`game/snake/snake.gd`:

```gdscript
class_name Snake extends Node2D

func _ready():
    GameState.snake = self   # register so entities can find the game
    start()

func start():
    ...
```

**3. Register the game on `GameState`** (`game/game_state.gd`)

```gdscript
var scenes:Dictionary = {
    ...
    "snake": load("res://game/snake/snake.tscn"),
}
var snake:Snake                 # live reference, assigned in the game's _ready()
var snake_highscores:Array      # if the game keeps a score
```

Then add the highscore key to **both** `save_to_file()` and `load_from_file()` — the
load side needs the `if not save_data.has(...)` fallback so existing saves keep working —
and include the array in `sort_highscores()`.

**4. Add the menu button**

In `game/minigames.tscn`, add a `Button` to `Control/VBoxContainer` following the
existing text style (` sNaKe `), and connect its `pressed` signal to a new handler in
`game/minigames.gd`:

```gdscript
func _on_snake_pressed():
    GameState.enter("snake")
```

**5. Declare input actions**

Project → Project Settings → Input Map, named `"<Game> <action>"`. They land in
`project.godot` under `[input]`; commit that change with the game.

**6. Provide a way out**

Every game must reach `GameState.exit()` — through the pause menu (which works
automatically), and through its own game over screen. A game the player can only leave
with `ESC` is not finished.

**Before calling it done:** a start state, a fail or win state, a score or completion
condition, and a return to the menu. See `sprints.md` — prototypes in this project
consistently stall right before the loss condition.

---

## Adding art and audio

- Drop files into `resources/png/`, `resources/ttf/` or `resources/Audio + SFX/`. Godot
  generates a `.import` sidecar — **commit the `.import` file too**, or the asset will
  not resolve on another machine.
- Keep the pixel-art look: match the existing sprite scale, and use the shared theme
  resources in `resources/tres/` (`pixel_text.tres`, `pixelmap.tres`) rather than
  styling labels ad hoc.
- Sprite import settings: nearest-neighbour filtering, no mipmaps.

---

## Changing the save format

`user://minigames.save` is a single line of JSON. When the schema changes:

1. Add the new key to `save_to_file()`.
2. Add it to `load_from_file()` **with a fallback** for saves that predate it, following
   the existing `if not save_data.has(...)` pattern.
3. Bump `const game_version` in `game/game_state.gd`.
4. Record the change under `[Unreleased]` in `changelog.md`.
5. Test against a real old save. On Linux the file lives under
   `~/.local/share/godot/app_userdata/Minigames/`; on Windows under
   `%APPDATA%\Godot\app_userdata\Minigames\`.

Never remove a key without a migration — deleting it silently discards a player's
progress, which is exactly what the currently commented-out `platformer_saves` load is
doing (see `backlog.md` BUG-04).

---

## Testing

There is no automated test suite yet (`backlog.md` PROC-01). Until there is, before
committing:

- Play every game you touched, from the menu, all the way to its end state.
- Press `ESC` mid-game and confirm the pause menu opens and both buttons work.
- Enter a high score, quit the application entirely, relaunch, and confirm it is still
  there.
- Watch the output panel — `game_state.gd` prints its save and load data, and stray
  errors surface there rather than on screen.

`line_counter.gd` is available as a tool script: open it in the editor and use
**File → Run** for a code/comment/total line count.

---

## Git workflow

- Work happens on `master`. All thirteen commits so far are direct.
- Commit messages are short, lowercase and descriptive of the outcome:
  `"made highscores universal, not one per game"`, `"breakout almost done, need to do
  highscores and maybe tap to start"`. Noting what is still unfinished in the message is
  a genuinely useful habit here — keep it.
- Commit the whole feature together: script, scene, `project.godot` input changes and
  imported assets. A game committed without its `.import` files does not run elsewhere.
- Do not commit `.godot/` (already git-ignored) or `user://` save data.

## Keeping the docs current

- `changelog.md` — add to `[Unreleased]` as work lands.
- `backlog.md` — add items as you find them, remove them as you fix them.
- `sprints.md` — close the current sprint and open the next when a chunk of work lands.
- `roadmap.md` / `vision.md` — only when direction actually changes.
- `README.md` — kept by the author as informal notes; the structured planning now lives
  here.
