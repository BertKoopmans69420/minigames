class_name FlapperWall extends StaticBody2D
var speed = 200
func _ready():
	position.y = randf_range(-448.0, 64.0)

func _process(delta):
	position.x -= (speed * delta)
