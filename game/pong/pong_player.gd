class_name PongPlayer extends CharacterBody2D

@export var id:int = 0
var speed = 300.0

func _process(delta):
	velocity.x = 0
	var direction
	if id == 0:
		if position.x != 56:
			position.x = 56
		direction = Input.get_axis("Pong up 1", "Pong down 1")
	else:
		rotation_degrees = 180
		if position.x != 1152-56:
			position.x = 1152-56
		direction = Input.get_axis("Pong up 2", "Pong down 2")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
