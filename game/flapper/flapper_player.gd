class_name FlapperPlayer extends CharacterBody2D
 

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	move_and_slide()

func _input(event):
	if event.is_action_pressed("Flapper jump"):
		velocity.y = -350
