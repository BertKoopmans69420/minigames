class_name BreakoutPowerup extends Area2D

var power:String
func _ready():
	$Powerups.get_child(find_powerup()).visible = true

func find_powerup():
	match power:
		"laser":
			return 0
		"triple balls":
			return 1
		"wide pad":
			return 2
		"short pad":
			return 3
		"slower balls":
			return 4
		"faster balls":
			return 5
		"safe floor (3 times)":
			return 6
		"extra life":
			return 7

func _process(delta):
	position.y += 300 * delta

func _on_body_entered(body):
	if body is BreakoutPlayer:
		GameState.breakout.powerup(power)
		queue_free()
