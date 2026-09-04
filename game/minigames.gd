class_name MiniGames extends Node2D

@onready var menu = $Control
@onready var games = $Games
@onready var pause_menu = $Pause_menu
func _ready():
	GameState.MINIGAMES = self

func _on_pong_pressed():
	GameState.enter("pong")


func _on_breakout_pressed():
	GameState.enter("breakout")


func _on_platformer_pressed():
	GameState.enter("platformer")


func _on_shooter_pressed():
	GameState.enter("shooter")

func _on_flapper_pressed():
	GameState.enter("flapper")


func _on_2048_pressed():
	GameState.enter("2048")


func _on_snake_pressed():
	GameState.enter("snake")


func _on_quit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("F11"):
		var window = get_window()
		if window.mode != Window.MODE_EXCLUSIVE_FULLSCREEN:
			window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			window.mode = Window.MODE_WINDOWED


func _on_speed_typing_pressed():
	GameState.enter("speed_typing")
