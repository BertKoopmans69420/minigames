class_name Pong extends Node2D

@onready var ball = $Pong_Ball
func _ready():
	GameState.pong = self
	ball.move = false
	$Player_1_score.text = "0"
	$Player_2_score.text = "0"
	$VBoxContainer.visible = true
	GameState.pong_add_score.connect(add_score)

func add_score(side:int):
	if side == -1:
		$Player_2_score.text = str(int($Player_2_score.text) + 1)
	if side == 1:
		$Player_1_score.text = str(int($Player_1_score.text) + 1)
	if int($Player_1_score.text) == 10 or int($Player_2_score.text) == 10:
		ball.move = false
		end()
		if int($Player_1_score.text) == 10:
			if !$Pong_Player_1.cpu:
				$Label1.visible = true
			else:
				$Label5.visible = true
		if int($Player_2_score.text) == 10:
			if !$Pong_Player_1.cpu:
				$Label2.visible = true
			else:
				$Label6.visible = true


func end():
	$VBoxContainer.visible = true
	$Label3.visible = false
	$Label4.visible = false


func play():
	$Pong_Player_1.position.y = 324
	$Pong_Player_2.position.y = 324
	$Player_1_score.text = "0"
	$Player_2_score.text = "0"
	$Label1.visible = false
	$Label2.visible = false
	$Label3.visible = false
	$Label4.visible = false
	$Label5.visible = false
	$Label6.visible = false
	$Label7.visible = false
	$Label8.visible = false
	$VBoxContainer.visible = false
	ball.move = true
	ball.start(1)
	


func _on_home_pressed():
	$VBoxContainer.visible = false
	GameState.exit()


func _on_play_1p_pressed():
	$VBoxContainer.visible = false
	$Pong_Player_1.cpu = true
	play()


func _on_play_2p_pressed():
	$VBoxContainer.visible = false
	$Pong_Player_1.cpu = false
	play()
