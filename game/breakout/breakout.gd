class_name Breakout extends Node2D

@onready var powerups = $Powerups
@onready var balls = $Balls
@onready var player = $Breakout_Player
var level = 0
var highscore = 66099 #Fake (Sarah)

var ballscene = load("res://game/breakout/breakout_ball.tscn")
var floorscene = load("res://game/breakout/breakout_safe_floor.tscn")
var brickscene = load("res://game/breakout/breakout_brick.tscn")
var lives:int:
	set(value):
		lives = value
		$Lives.text = str("X", value)

var points:int:
	set(value):
		points = value
		$Points.text = str(value, "P")

func _ready():
	lives = 3
	points = 0
	GameState.breakout = self
	set_level()
func _process(delta):
	if balls.get_children() == []:
		lives -= 1
		new_ball()
		
	if $Bricks.get_children() == []:
		level += 1
		set_level()
		
	if lives == 0:
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
			lives += 1

func new_ball():
	var ball = ballscene.instantiate()
	ball.min_speed = ball.minimum_speed + level * 10
	ball.position.x = $Breakout_Player.position.x + randf_range(-32, 32)
	ball.position.y = $Breakout_Player.position.y - 48
	ball.move = false
	balls.add_child(ball)

func set_level():
	for marker:Marker2D in $Breakout_Levels.get_child(level % 3).get_children():
		var brick = brickscene.instantiate()
		brick.global_position = marker.global_position
		brick.strength = randi_range(1, level + 1)

		
		$Bricks.add_child(brick)
		

func end():
	await get_tree().create_timer(2.0).timeout
	GameState.exit()
