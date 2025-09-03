class_name PlatformerPlayer extends CharacterBody2D
var jump_velocity = -1.5
var in_water = false
var speed = 200
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Handle jump.
	if Input.is_action_just_pressed("Platformer jump") and is_on_floor():
		velocity.y = jump_velocity * speed
 
	#if Input.is_action_just_pressed("faster"):
		#speed = speed * 2
	#if Input.is_action_just_released("faster"):
		#speed = speed / 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Platformer left", "Platformer right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed / 2)
	else:
		velocity.x = move_toward(velocity.x, 0, speed / 2)

	#death if below screen
	if position.y > get_window().size.y:
		GameState.platformer.to_menu()

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collision_point = collision_info.get_position()
		#print(collision_point)
		var collider = collision_info.get_collider()

		#print(collider)

		#velocity.y = jump_velocity


	move_and_slide()
