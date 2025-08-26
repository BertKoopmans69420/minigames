class_name Breakout extends Node2D

@onready var powerups = $Powerups
@onready var balls = $Balls
@onready var player = $Breakout_Player
var ballscene = load("res://game/breakout/breakout_ball.tscn")
var floorscene = load("res://game/breakout/breakout_safe_floor.tscn")
func _ready():
	GameState.breakout = self
func _process(delta):
	if balls.get_children() == []:
		pass #lose_life
		new_ball()
		
	if $Bricks.get_children() == []:
		end()

func powerup(power:String):
	match power:
		"laser":
			for ball:BreakoutBall in balls.get_children():
				ball.laser = true
				ball.modulate = Color(1, .5, 0, 1)
				ball.set_collision_layer_value(2, false)
				ball.set_collision_mask_value(1, false)
				ball.timer = 10.0
		"triple balls":
			for i in 2:
				var ball = ballscene.instantiate()
				ball.move = false
				ball.position = Vector2(-8, -8)
				ball.direction = Vector2(randf_range(-1,1), randf_range(0.25,1))
				balls.add_child(ball)
		"wide pad":
			$Breakout_Player.scale.x = 2
			$Breakout_Player.timer = 30.0
		"short pad":
			$Breakout_Player.scale.x = .5
			$Breakout_Player.timer = 30.0
		"slower balls":
			for ball:BreakoutBall in balls.get_children():
				ball.speed -= 50
		"faster balls": 
			for ball:BreakoutBall in balls.get_children():
				ball.speed += 50
		"safe floor (3 times)":
				$Floors.remove_child($Floors.get_child(0))
				var floor = floorscene.instantiate()
				$Floors.add_child(floor)
		"extra life":
			return 7

func new_ball():
	var ball = ballscene.instantiate()
	ball.position.x = $Breakout_Player.position.x + randf_range(-32, 32)
	ball.position.y = $Breakout_Player.position.y - 48
	ball.move = false
	balls.add_child(ball)

func end():
	await get_tree().create_timer(2.0).timeout
	GameState.exit()
