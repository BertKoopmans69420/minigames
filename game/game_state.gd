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

func enter(scene:String):
	var loaded:PackedScene = scenes.get(scene)
	var minigame = loaded.instantiate()
	MINIGAMES.menu.visible = false
	MINIGAMES.games.add_child(minigame)

func exit():
	MINIGAMES.menu.visible = true
	if MINIGAMES.games.get_children() != null:
		MINIGAMES.games.get_child(0).queue_free()


func _input(event):
	if event.is_action_pressed("ESC"):
		pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
		
