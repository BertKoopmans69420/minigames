class_name Shooter extends Node2D
@onready var player:ShooterPlayer = $Shooter_Player
var start_time:int
var end_time:int
var time:int
var enemy_scene:PackedScene = preload("res://game/shooter/shooter_enemy.tscn")
var enemy_spawn_timer:float = 0.0
var enemy_spawn_time:float = 4.2
var spawns = 0
var current_time:int = 0
func _ready():
	GameState.shooter = self
	start()

func start():
	player.position = Vector2(576, 324)
	enemy_spawn_timer = 0.0
	enemy_spawn_time = 3.0
	spawns = 0
	start_time = Time.get_ticks_msec()
	

func _process(delta):
	#current_time = floori(Time.get_ticks_msec() / 1000) - floori(start_time / 1000)
	if player.move:
		if floori(Time.get_ticks_msec() / 1000) - floori(start_time / 1000) > current_time:
			$Timer.text = set_time_s(current_time)
		
		
		if enemy_spawn_timer > 0.0: 
			enemy_spawn_timer -= delta
		if enemy_spawn_timer <= 0.0:
			spawn_enemy()
			enemy_spawn_time -= enemy_spawn_time / 69
			enemy_spawn_timer = enemy_spawn_time
	current_time = floori(Time.get_ticks_msec() / 1000) - floori(start_time / 1000)

func spawn_enemy():
	var pos:Vector2 = Vector2(0, 0)
	var x_y = ["x", "y"]
	var x = [-8, 1160]
	var y = [-8, 656]
	var axis = x_y[randi_range(0, 1)]
	if axis == "x":
		pos.x = randf_range(x[0], x[1])
		pos.y = y[randi_range(0, 1)]
	elif axis == "y":
		pos.x = x[randi_range(0, 1)]
		pos.y = randf_range(y[0], y[1])
	if pos.distance_to(player.position) < 100:
		return
	var enemy:ShooterEnemy = enemy_scene.instantiate()
	enemy.position = pos
	add_child(enemy)
	
	
func end():
	end_time = Time.get_ticks_msec()
	time = end_time - start_time
	print(time)
	player.move = false
	for child in get_children():
		if child is ShooterEnemy:
			child.queue_free()
	show_high_scores()

func set_time_s(stime) -> String:
	var time_text:String
	var rest_time:int = stime
	var s = str(rest_time % 60)
	rest_time = (rest_time - int(s)) / 60
	var m = str(rest_time % 60)
	if int(m) == 0:
		m = "-"
	if int(s) < 10 and m != "-":
		s = "0" + s
	if m != "-":
		time_text = str(m, ":", s)
	elif  m == "-" and s != "00":
		time_text = str(s)
	return time_text
		
func set_time(mstime:int) -> String:
	var time_text:String
	var rest_time:int = mstime
	var ms = str(rest_time % 1000)
	rest_time = (rest_time - int(ms)) / 1000
	var s = str(rest_time % 60)
	rest_time = (rest_time - int(s)) / 60
	var m = str(rest_time % 60)
	if int(m) == 0:
		m = "-"
	if int(s) < 10 and m != "-":
		s = "0" + s
	if int(ms) < 100 and s != "00":
		ms = "0" + ms
		if int(ms) < 10:
			ms = "0" + ms
	if m != "-":
		time_text = str(m, ":", s, ".", ms)
	elif  m == "-" and s != "00":
		time_text = str(s, ".", ms)
	elif  m == "-" and s == "00" or s == "0":
		time_text = str(ms)
	return time_text
	
	
	

	
func show_high_scores():
	$Shooter_High_Scores.visible = true
	$Shooter_High_Scores/Name.visible = true
	$Shooter_High_Scores/Name.grab_focus()
