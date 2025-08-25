class_name PauseMenu extends Node2D

func _ready():
	GameState.pause_menu = self

func _on_continue_pressed():
	unpause()

func _on_exit_pressed():
	unpause()
	GameState.exit()

func unpause():
	visible = false
	get_tree().paused = false
