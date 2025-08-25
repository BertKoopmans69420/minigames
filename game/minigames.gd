class_name MiniGames extends Node2D

@onready var menu = $Control
@onready var games = $Games
@onready var pause_menu = $Pause_menu
func _ready():
	GameState.MINIGAMES = self

func _on_pong_pressed():
	GameState.enter("pong")


func _on_breakout_pressed():
	pass # Replace with function body.


func _on_platformer_pressed():
	pass # Replace with function body.


func _on_shooter_pressed():
	pass # Replace with function body.
