class_name BreakoutBall extends CharacterBody2D
const minimum_speed = 150
var min_speed = 150
var speed:float = 150
var direction:Vector2 = Vector2(0, 0)
var move = true
var laser = false
var timer = 0.0
var direct = false

func _ready():
	start()
func start():
	if !direct:
		await get_tree().create_timer(1.0).timeout
	speed = min_speed
	move = true
	position = Vector2(GameState.breakout.player.position.x, GameState.breakout.player.position.y - 52)
	if direction == Vector2(0, 0):
		direction.y = -1
		direction.x = .5

func _process(delta):
	if speed < min_speed + 5 * GameState.breakout.level:
		speed = min_speed + 5 * GameState.breakout.level
	if timer > 0.0:
		timer -= delta
	if timer <= 0.0:
		laser = false
		modulate = Color(1, 1, 1, 1)
		set_collision_layer_value(2, true)
		set_collision_mask_value(1, true)
	if position.y > get_window().size.y:
		queue_free()


	if !move:
		direction = Vector2(0, 0)
	velocity = direction.normalized() * speed
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider is BreakoutPlayer:
			direction.y = -direction.y
			var angle = get_angle_to(collider.position)
			direction.x = -cos(angle)
			speed += 1
		elif collider is BreakoutSafeFloor:
			collider.hit()
			direction.y = -direction.y
		else: 
			if collider is BreakoutBrick:
				collider.destroy()
			if collision_info.get_position().x >= position.x + 7 or collision_info.get_position().x <= position.x - 7:
				direction.x = -direction.x
			elif collision_info.get_position().y >= position.y + 7 or collision_info.get_position().y <= position.y - 7:
				direction.y = -direction.y
			else:
				direction.x = -direction.x
				direction.y = -direction.y
				if direction.y == 0:
					direction.y = -0.001
	move_and_slide()


func _on_laser_body_entered(body):
	if body is BreakoutBrick:
		if laser == true:
			body.laser_destroy()
