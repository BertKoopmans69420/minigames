class_name Pong extends Node2D

func _ready():
	$Player_1_score.text = "0"
	$Player_2_score.text = "0"
	GameState.pong_add_score.connect(add_score)

func add_score(side:int):
	if side == -1:
		$Player_2_score.text = str(int($Player_2_score.text) + 1)
	if side == 1:
		$Player_1_score.text = str(int($Player_1_score.text) + 1)
	if int($Player_1_score.text) == 10 or int($Player_2_score.text) == 10:
		$Pong_Ball.move = false
		end()

func end():
	await get_tree().create_timer(2.0).timeout
	GameState.exit()
