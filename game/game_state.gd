extends Node

signal pong_add_score(side) #left -1, right 1 

var scenes:Dictionary = {	"pong": load("res://game/pong/pong.tscn"),
							"breakout": load("res://game/breakout/breakout.tscn"),
							"platformer": load("res://icon.svg"),
							"shooter": load("res://icon.svg")
						}
var MINIGAMES:MiniGames
var pause_menu:PauseMenu
var pong:Pong
var breakout:Breakout

var breakout_highscores:Array = [["neh", 1258743], ["dan", 1780], ["---", 0], ["---", 0], ["---", 0]]



const game_version = "0.2"
const save_filename = "user://minigames.save"
func _ready():
	save()
	process_mode = Node.PROCESS_MODE_ALWAYS
	load_save_file()
	


func enter(scene:String):
	var loaded:PackedScene = scenes.get(scene)
	var minigame = loaded.instantiate()
	MINIGAMES.menu.visible = false
	MINIGAMES.games.add_child(minigame)

func exit():
	MINIGAMES.menu.visible = true
	if MINIGAMES.games.get_children() != []:
		MINIGAMES.games.get_child(0).queue_free()

func _input(event):
	if event.is_action_pressed("ESC"):
		pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused

func sort_highscores():
	breakout_highscores.sort_custom(highscore_sort)
	while len(breakout_highscores) >= 6:
		breakout_highscores.remove_at(5)
func highscore_sort(a, b):
	if a[1] > b[1]:
		return true
	return false
























func load_save_file():
	load_from_file(save_filename)

func load_from_file(filename:String):
	if FileAccess.file_exists(filename):
		print("Loading save data")
		var save_file = FileAccess.open(filename, FileAccess.READ)
		if not save_file:
			var err:Error = FileAccess.get_open_error()
			printerr("Failed to open save file: ", err)
			get_tree().quit(err)
		
		var save_data:Dictionary = _load_json_line(save_file)
		if not save_data.has("game_version"):
			print("Missing version info. Ignoring save data")
			return

		GameState.breakout_highscores = save_data["breakout_highscores"]

		print_save_data(filename)

func _load_json_line(file:FileAccess) -> Variant:
	var line = file.get_line()
	var json = JSON.new()
	var err:Error = json.parse(line)
	if err != OK:
		printerr("Failed to parse save file at line ", json.get_error_line(), " with failure: ", json.get_error_message())
		get_tree().quit(err)
		
	print("Loaded:\n",json.data)
	return json.data

func save() -> void:
	save_to_file(save_filename)
func save_to_file(filename:String):
	var save_file = FileAccess.open(filename, FileAccess.WRITE)
	
	var save_data = {
		"game_version" : GameState.game_version,
		"breakout_highscores" : GameState.breakout_highscores,

	}
	
	var data = JSON.stringify(save_data, "", true, true)
	save_file.store_line(data)
	save_file.close()
	print_save_data(filename)

func print_save_data(filename:String):
	if FileAccess.file_exists(filename):
		print("Load: ", filename,":\n" )
		_load_json_line(FileAccess.open(filename, FileAccess.READ))
