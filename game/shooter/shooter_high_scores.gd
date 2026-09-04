class_name ShooterHighScores extends Control
var text:String = ""

func show_scores():
	for i in len($VBoxContainer.get_children()):
		if $VBoxContainer.get_child(i) is HBoxContainer:
			$VBoxContainer.get_child(i).get_child(1).text = str(GameState.shooter_highscores[i][0])
			#$VBoxContainer.get_child(i).get_child(2).text = str(int(GameState.shooter_highscores[i][1]))
			$VBoxContainer.get_child(i).get_child(2).text = str(GameState.shooter.set_time(int(GameState.shooter_highscores[i][1])))



func _on_name_changed(new_text):
	text = new_text



func _on_ok_pressed(_new_text):
	if len(text) != 3:
		$Name.grab_focus()
		return
	else:
		$Name.visible = false
	GameState.shooter_highscores.append([text, GameState.shooter.time])
	$Name.visible = false
	#$Name/Label.visible = false
	#$Name/Label/SingleColor.visible = false
	GameState.sort_highscores()
	$VBoxContainer.visible = true
	show_scores()
	GameState.save()

func skip_name_enter():
	GameState.shooter_highscores.append(["---", GameState.shooter.time])
	$Name.visible = false
	GameState.sort_highscores()
	$VBoxContainer.visible = true
	show_scores()
	GameState.save()

func _on_exit_pressed():
	GameState.exit()


func _on_continue_pressed():
	$VBoxContainer.visible = false
	visible = false
	GameState.shooter._ready()
