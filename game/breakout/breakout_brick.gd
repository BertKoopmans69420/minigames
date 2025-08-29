class_name BreakoutBrick extends StaticBody2D
var strength = 1
var powerup_scene:PackedScene = load("res://game/breakout/breakout_powerup.tscn")

func _ready():
	change_color()

func destroy():
	GameState.breakout.points += strength
	strength -= 1
	
	if strength <= 0:
		if randi_range(1, 5) == 1:
			drop_powerup()
		$CollisionShape2D.position.y = -1000
		$CollisionShape2D.disabled = true
		die()
	else:
		if randi_range(1, 10) == 1:
			drop_powerup()
		change_color()

func laser_destroy():
	if randi_range(1, 8) == 1:
		drop_powerup()
	var total = 0
	for i in strength:
		total += i + 1
	GameState.breakout.points += total
	die()
	

func drop_powerup():
	var power:String
	var number =  randi_range(1, 21)
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
		9:
			power = "laser"
		10:
			power = "triple balls"
		11:
			power = "wide pad"
		12:
			power = "short pad"
		13:
			power = "slower balls"
		14:
			power = "faster balls"
		15:
			power = "safe floor (3 times)"
		16:
			power = "laser"
		17:
			power = "triple balls"
		18:
			power = "wide pad"
		19:
			power = "short pad"
		20:
			power = "slower balls"
		21:
			power = "faster balls"
	var powerup = powerup_scene.instantiate()
	powerup.global_position = global_position
	powerup.power = power
	GameState.breakout.powerups.add_child(powerup)

func change_color():
	match strength:
		1:
			modulate = Color(1, 1, 1, 1)
		2:
			modulate = Color(1, 0, 0, 1)
		3:
			modulate = Color(1, .5, 0, 1)
		4:
			modulate = Color(1, 1, 0, 1)
		5:
			modulate = Color(.5, 1, 0, 1)
		6:
			modulate = Color(0, 1, 0, 1)
		7:
			modulate = Color(0, 1, .5, 1)
		8:
			modulate = Color(0, 1, 1, 1)
		9:
			modulate = Color(0, .5, 1, 1)
		10:
			modulate = Color(0, 0, 1, 1)
		11:
			modulate = Color(.5, 0, 1, 1)
		12:
			modulate = Color(1, 0, .5, 1)
		_:
			modulate = Color(.5, .5, .5, 1)

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
	await get_tree().create_timer(.05).timeout
	queue_free()
