class_name PongBall extends CharacterBody2D

var speed:float = 160
var direction:Vector2 = Vector2(0, 0)
var move = true
func _ready():
	start(1)
	
func start(side):
	await get_tree().create_timer(1.0).timeout
	direction.x = side
	direction.y = randf_range(-1.0, 1.0)



func _process(delta):
	if position.x > get_window().size.x:
		score(1)
	if position.x < 0:
		score(-1)
	if !move:
		direction = Vector2(0, 0)
	velocity = direction.normalized() * speed
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider is PongPlayer:
			direction.x = -direction.x
			var angle = -1 * get_angle_to(collider.position)
			if abs(position.y - collider.position.y) >= 24.0:
				direction.y = sin(angle * (4.0/5.0))
			else:
				direction.y = sin(angle * (3.0/5.0))
			speed += 10
		else: 
			direction.y = -direction.y
	move_and_slide()

func score(side:int):
	GameState.pong_add_score.emit(side)
	start(side)
	position = Vector2(576, 324)
	direction = Vector2(0, 0)
	speed = 160
