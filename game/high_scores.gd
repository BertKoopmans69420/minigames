class_name HighScores extends Control
var text:String = ""
var game
var highscores:Array

func set_game(game_name):
	match game_name:
		"Breakout":
			game = GameState.breakout
			highscores = GameState.breakout_highscores
		"Shooter":
			game = GameState.shooter
			highscores = GameState.shooter_highscores

func show_scores():
	for i in len($VBoxContainer.get_children()):
		if $VBoxContainer.get_child(i) is HBoxContainer:
			$VBoxContainer.get_child(i).get_child(1).text = str(highscores[i][0])
			if game == GameState.shooter:
				$VBoxContainer.get_child(i).get_child(2).text = str(game.set_time(int(highscores[i][1])))
			else:
				$VBoxContainer.get_child(i).get_child(2).text = str(int(highscores[i][1]))



func _on_name_changed(new_text):
	text = new_text



func _on_ok_pressed(_new_text):
	if len(text) != 3:
		$Name.grab_focus()
		return
	else:
		$Name.visible = false
	enter_name(text)
	$Name.visible = false
	#$Name/Label.visible = false
	#$Name/Label/SingleColor.visible = false
	GameState.sort_highscores()
	$VBoxContainer.visible = true
	show_scores()
	GameState.save()

func skip_name_enter():
	enter_name("---")
	$Name.visible = false
	GameState.sort_highscores()
	$VBoxContainer.visible = true
	show_scores()
	GameState.save()


func enter_name(entered_name:String):
	match game:
		GameState.breakout:
			GameState.breakout_highscores.append([entered_name, GameState.breakout.points])
		GameState.shooter:
			GameState.shooter_highscores.append([entered_name, GameState.shooter.time])
	
	

func _on_exit_pressed():
	GameState.exit()


func _on_continue_pressed():
	if game == GameState.breakout:
		for i in GameState.breakout.bricks.get_children():
			GameState.breakout.bricks.get_child(0).queue_free()
		$VBoxContainer.visible = false
		visible = false
		#GameState.shooter._ready()
