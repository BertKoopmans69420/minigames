class_name ShooterPlayer extends CharacterBody2D
var speed = 150
var dir: Vector2 = Vector2(1, 0)
var bullet_scene:PackedScene = preload("res://game/shooter/shooter_bullet.tscn")
var move = true
func _process(delta):
	GameState.shooter.player = self

 
	#if Input.is_action_just_pressed("faster"):
		#speed = speed * 2
	#if Input.is_action_just_released("faster"):
		#speed = speed / 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = Input.get_vector("Shooter left", "Shooter right", "Shooter up", "Shooter down")
	if direction:
		if move:
			velocity.x = move_toward(velocity.x, direction.x * speed, speed / 2)
			velocity.y = move_toward(velocity.y, direction.y * speed, speed / 2)
			dir = direction
			look_at(global_position + direction)
		else:
			velocity = Vector2(0, 0)
	else:
		velocity.x = move_toward(velocity.x, 0, speed / 2)
		velocity.y = move_toward(velocity.y, 0, speed / 2)


	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collision_point = collision_info.get_position()
		#print(collision_point)
		var collider = collision_info.get_collider()
		if collider is ShooterEnemy:
			die()
		#print(collider)

		#velocity.y = jump_velocity


	move_and_slide()

func _input(event):
	if move:
		if event.is_action_pressed("Shooter shoot"):
			shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.direction = dir
	bullet.global_position = global_position + 14 * dir
	GameState.shooter.add_child(bullet)

func die():
	GameState.shooter.end()
