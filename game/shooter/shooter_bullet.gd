class_name ShooterBullet extends CharacterBody2D

var direction
var speed = 450



func _ready():
	look_at(global_position + direction)
	velocity = direction * speed
func _process(delta):
	if position.x > 1168 or position.x < -16 or position.y > 644 or position.y < -16:
		queue_free()
	look_at(global_position + direction)
	velocity = direction * speed

	move_and_slide()




func _on_area_2d_body_entered(body):
	if body is ShooterEnemy:
		body.die()
		queue_free()
