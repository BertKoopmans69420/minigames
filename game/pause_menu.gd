class_name PauseMenu extends Node2D

@onready var exit = $Control/VBoxContainer/exit

func _ready():
	GameState.pause_menu = self

func _on_continue_pressed():
	unpause()

func _on_exit_pressed():
	unpause()
	if GameState.platformer and GameState.platformer.in_level == true:
		GameState.platformer.to_menu()
	else:
		GameState.exit()

func unpause():
	visible = false
	get_tree().paused = false
