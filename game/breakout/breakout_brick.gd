class_name BreakoutBrick extends StaticBody2D

var powerup_scene:PackedScene = load("res://game/breakout/breakout_powerup.tscn")

func destroy():
	$CollisionShape2D.position.y = -1000
	$CollisionShape2D.disabled = true
	if randi_range(1, 6) == 1:
		drop_powerup()
	#give points
	die()
	await get_tree().create_timer(.5).timeout
	queue_free()

func drop_powerup():
	var power:String
	var number =  randi_range(1, 8)
	#var number = 2
	match number:
		1:
			power = "laser"
		2:
			power = "triple balls"
		3:
			power = "wide pad"
		4:
			power = "short pad"
		5:
			power = "slower balls"
		6:
			power = "faster balls"
		7:
			power = "safe floor (3 times)"
		8:
			power = "extra life"
	var powerup = powerup_scene.instantiate()
	powerup.global_position = global_position
	powerup.power = power
	GameState.breakout.powerups.add_child(powerup)

func die():
	visible = false
	await  get_tree().create_timer(.05).timeout
	visible = true
	await  get_tree().create_timer(.1).timeout
	visible = false
	await  get_tree().create_timer(.05).timeout
	visible = true
	await  get_tree().create_timer(.1).timeout
	visible = false
	await  get_tree().create_timer(.05).timeout
	visible = true
	await  get_tree().create_timer(.05).timeout
	visible = false
	await  get_tree().create_timer(.05).timeout
	visible = true
