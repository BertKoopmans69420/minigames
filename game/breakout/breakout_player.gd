class_name BreakoutPlayer extends CharacterBody2D

var mouse_pos
var speed = 400.0
var timer = 0.0

func _process(delta):
	if timer > 0.0:
		timer -= delta
	if timer <= 0.0:
		scale.x = 1
	if mouse_pos != get_global_mouse_position():
		position.x = get_global_mouse_position().x
	mouse_pos = get_global_mouse_position()
	var direction
	if position.y != get_window().size.y - 32:
		position.y = get_window().size.y - 32
	if position.x <= 32 * scale.x:
		position.x = 32 * scale.x
	if position.x >= 1152 - 32 * scale.x:
		position.x = 1152 - 32 * scale.x
	direction = Input.get_axis("Breakout left", "Breakout right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
