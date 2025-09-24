class_name ShooterEnemy extends CharacterBody2D
var speed = 42

func _process(delta):
	look_at(GameState.shooter.player.global_position)
	velocity = Vector2(cos(rotation), sin(rotation)).normalized() * speed
	move_and_slide()

func die():
	queue_free()
