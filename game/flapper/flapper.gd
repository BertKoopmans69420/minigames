class_name Flapper extends Node2D

const wall_spawn_time:float = 2.0
var wall_spawn_timer = wall_spawn_time
var wall_scene = preload("res://game/flapper/flapper_wall.tscn")
@onready var walls:Node2D = $Walls

func _ready():
	$ParallaxBackground/Parallax2D.autoscroll.x = 0.0
	start()

func start():
	$ParallaxBackground/Parallax2D.autoscroll.x = -32.0

func _process(delta):
	wall_spawn_timer -= delta
	if wall_spawn_timer <= 0:
		wall_spawn_timer = wall_spawn_time
		spawn_wall()

func spawn_wall():
	var wall = wall_scene.instantiate()
	wall.position.x = 1152
	walls.add_child(wall)
