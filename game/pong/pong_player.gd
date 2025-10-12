class_name PongPlayer extends CharacterBody2D

@export var id:int = 0
var speed = 300.0
var cpu = true

func _process(_delta):
	velocity.x = 0
	var direction
	if !cpu:
		if id == 0:
			if position.x != 56:
				position.x = 56
			direction = Input.get_axis("Pong up 1", "Pong down 1")
		else:
			rotation_degrees = 180
			if position.x != 1152-56:
				position.x = 1152-56
			direction = Input.get_axis("Pong up 2", "Pong down 2")
	else:
		if id == 0:
			if position.x != 56:
				position.x = 56
			
		else:
			rotation_degrees = 180
			if position.x != 1152-56:
				position.x = 1152-56
			direction = Input.get_axis("Pong up 2", "Pong down 2")
	if !cpu:
		if direction:
			velocity.y = direction * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
	else:
		if id == 1:
			if direction:
				velocity.y = direction * speed
			else:
				velocity.y = move_toward(velocity.y, 0, speed)
		if id == 0:
			if GameState.pong.ball.position.y > position.y + 16:
				velocity.y = speed
			elif GameState.pong.ball.position.y < position.y - 16:
				velocity.y = -speed
			else:
				velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
