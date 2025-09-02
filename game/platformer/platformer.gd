class_name Platformer extends Node2D
var last_completed_world:int = 1
var last_completed_level:int = 0
var lives:int = 3
var coins:int = 1
var current_world:int = 1
var final_world:int = 8 # final world
var in_level = false
var platformer_levels:Dictionary = {"World 1" : {	"Level 1" : load("res://game/platformer/levels/1-1.tscn"),} 
													#"Level 2" : load("res://game/platformer/levels/1-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/1-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/1-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/1-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/1-6.tscn")},
									#"World 2" : {	"Level 1" : load("res://game/platformer/levels/2-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/2-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/2-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/2-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/2-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/2-6.tscn")},
									#"World 3" : {	"Level 1" : load("res://game/platformer/levels/3-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/3-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/3-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/3-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/3-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/3-6.tscn")},
									#"World 4" : {	"Level 1" : load("res://game/platformer/levels/4-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/4-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/4-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/4-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/4-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/4-6.tscn")},
									#"World 5" : {	"Level 1" : load("res://game/platformer/levels/5-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/5-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/5-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/5-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/5-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/5-6.tscn")},
									#"World 6" : {	"Level 1" : load("res://game/platformer/levels/6-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/6-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/6-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/6-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/6-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/6-6.tscn")},
									#"World 7" : {	"Level 1" : load("res://game/platformer/levels/7-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/7-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/7-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/7-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/7-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/7-6.tscn")},
									#"World 8" : {	"Level 1" : load("res://game/platformer/levels/8-1.tscn"), 
													#"Level 2" : load("res://game/platformer/levels/8-2.tscn"), 
													#"Level 3" : load("res://game/platformer/levels/8-3.tscn"), 
													#"Level 4" : load("res://game/platformer/levels/8-4.tscn"), 
													#"Level 5" : load("res://game/platformer/levels/8-5.tscn"), 
													#"Level 6" : load("res://game/platformer/levels/8-6.tscn")}
									}


func _ready():
	GameState.platformer = self
	start()
	pass

func start():
	if current_world == 1:
		$Control/Menu/World/Prev_World.disabled = true
	else:
		$Control/Menu/World/Prev_World.disabled = false
	
	if current_world == last_completed_world:
		if last_completed_level != 6:
			$Control/Menu/World/Next_World.disabled = true
		else:
			$Control/Menu/World/Next_World.disabled = false
	elif current_world < last_completed_world: 
		$Control/Menu/World/Next_World.disabled = false
	else:
		$Control/Menu/World/Next_World.disabled = true
		
	if current_world == final_world:
		$Control/Menu/World/Next_World.disabled = true
	set_levels()

func next_world():
	current_world += 1
	if current_world == last_completed_world:
		if last_completed_level != 6:
			$Control/Menu/World/Next_World.disabled = true
		else:
			$Control/Menu/World/Next_World.disabled = false
	elif current_world < last_completed_world: 
		$Control/Menu/World/Next_World.disabled = false
	else:
		$Control/Menu/World/Next_World.disabled = true
		
	if current_world == final_world:
		$Control/Menu/World/Next_World.disabled = true
	$Control/Menu/World/Prev_World.disabled = false
	set_levels()

func previous_world():
	current_world -= 1
	if current_world == 1:
		$Control/Menu/World/Prev_World.disabled = true
	else:
		$Control/Menu/World/Prev_World.disabled = false
	$Control/Menu/World/Next_World.disabled = false
	set_levels()
	
func set_levels():
	var levels = 1
	$Control/Menu/World/Curr_World.text = str("World ", current_world)
	for i in len($Control/Menu/Levels_1.get_children()):
		$Control/Menu/Levels_1.get_child(i).disabled = true
	for i in len($Control/Menu/Levels_2.get_children()):
		$Control/Menu/Levels_2.get_child(i).disabled = true
	if current_world < last_completed_world:
		levels = 6
	elif current_world == last_completed_world:
		if last_completed_level != 0:
			levels = last_completed_level
		else: 
			levels = 1
	else:
		levels = 1
		
	if levels > 3:
		for i in 3:
			$Control/Menu/Levels_1.get_child(i).disabled = false
		for i in levels - 3:
			$Control/Menu/Levels_2.get_child(i).disabled = false
	else:
		for i in levels:
			$Control/Menu/Levels_1.get_child(i).disabled = false



func _on_level_1_pressed():
	play_level(1)
func _on_level_2_pressed():
	play_level(2)
func _on_level_3_pressed():
	play_level(3)
func _on_level_4_pressed():
	play_level(4)
func _on_level_5_pressed():
	play_level(5)
func _on_level_6_pressed():
	play_level(6)

func play_level(chosen_level:int):
	var levelscene:PackedScene = platformer_levels[str("World ", current_world)][str("Level ", chosen_level)]
	var level = levelscene.instantiate()
	$Control.visible = false
	in_level = true
	$Level.add_child(level)
	print(level)

func to_menu():
	in_level = false
	$Control.visible = true
	$Level.get_child(0).queue_free()
