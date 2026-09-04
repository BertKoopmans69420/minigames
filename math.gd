class_name Math extends Node2D

signal open_gate
@export var level:int = -1 # -1 for all, otherwise normal levels
var number1
var equation_sign:String
var number2
var signs:Array = ["+", "-", "*", "/", "^"]
var allowed_signs:Array = []
var current_question = 0
var testing = false #set to false if normal play

func reset():

	current_question = 0
	if !testing:
		$PanelContainer/VBoxContainer/LineEdit.editable = false
	next_equation()

func _process(delta):
	if $PanelContainer/VBoxContainer/LineEdit.editable == true:
		if Input.is_anything_pressed():
			$PanelContainer/VBoxContainer/LineEdit.grab_focus()
	if $RIGHT.modulate.a != 0:
		$RIGHT.modulate.a = move_toward($RIGHT.modulate.a, 0, delta / 2)
	

func _ready():
	reset()
	
func _show():
	visible = true
	GameState.in_menu = true
	$PanelContainer/VBoxContainer/LineEdit.editable = true
	$PanelContainer/VBoxContainer/LineEdit.grab_focus()


func next_equation():
	current_question += 1
	$PanelContainer/Label.text = str(current_question, " / 10 ")
	make_equation(level)


func make_equation(equation_level):
	get_signs(equation_level)
	equation_sign = allowed_signs[randi_range(0, len(allowed_signs) - 1)]
	match equation_level:
		0:
			number1 = randi_range(0, 10)
			number2 = randi_range(0, 10)
		1:
			number1 = randi_range(0, 100)
			number2 = randi_range(0, 100)
		2:
			number1 = randi_range(0, 1000)
			number2 = randi_range(0, 1000)
		3:
			number1 = randi_range(0, 10)
			number2 = randi_range(0, 10)
			subtract()
		4:
			number1 = randi_range(0, 100)
			number2 = randi_range(0, 100)
			subtract()
		5:
			number1 = randi_range(0, 1000)
			number2 = randi_range(0, 1000)
			subtract()
		6:
			number1 = randi_range(0, 5)
			number2 = randi_range(0, 5)
		7:
			number1 = randi_range(0, 10)
			number2 = randi_range(0, 10)
		8:
			number1 = randi_range(0, 12)
			number2 = randi_range(0, 12)
		9:
			number1 = randi_range(0, 5)
			number2 = randi_range(1, 5)
			division()
		10:
			number1 = randi_range(0, 10)
			number2 = randi_range(1, 10)
			division()
		11:
			number1 = randi_range(0, 12)
			number2 = randi_range(1, 12)
			division()
		12:
			number1 = randi_range(0, 10)
			number2 = randi_range(0, 2)
		13:
			number1 = randi_range(0, 10)
			number2 = randi_range(0, 3)
		-1:
			match equation_sign:
				"+":
					number1 = randi_range(0, 100)
					number2 = randi_range(0, 100)
				"-":
					number1 = randi_range(0, 100)
					number2 = randi_range(0, 100)
					subtract()
				"*":
					number1 = randi_range(0, 12)
					number2 = randi_range(0, 12)
				"/":
					number1 = randi_range(0, 12)
					number2 = randi_range(1, 12)
					division()
				"^":
					number1 = randi_range(0, 10)
					number2 = randi_range(0, 3)
			
	
	
	show_equation()

func show_equation():
	$PanelContainer/VBoxContainer/Label.text = str(number1, " ", equation_sign, " ", number2, " = ?")
	$PanelContainer/VBoxContainer/LineEdit.grab_focus()


func division():
	number1 = number1 * number2
func subtract():
	if number2 > number1:
		var t = number2
		number2 = number1
		number1 = t


func get_signs(equation_level):
	if equation_level < 3:
		allowed_signs = signs.slice(0, 1)
	elif equation_level < 6:
		allowed_signs = signs.slice(1, 2)
	elif equation_level < 9:
		allowed_signs = signs.slice(2, 3)
	elif equation_level < 12:
		allowed_signs = signs.slice(3, 4)
	elif equation_level < 14:
		allowed_signs = signs.slice(4, 5)
	
	if equation_level == -1:
		allowed_signs = signs

		

func _on_line_edit_text_changed(new_text):
	if int(new_text):
		if new_text != str(int(new_text)):
			$PanelContainer/VBoxContainer/LineEdit.text = int(new_text)
	else:
		$PanelContainer/VBoxContainer/LineEdit.text = "" 
	var solution = equation_solution()
	if str(solution) == new_text:
		$RIGHT.modulate.a = 1
		$RIGHT.text =  str(number1, " ", equation_sign, " ", number2, " = ", new_text)
		$PanelContainer/VBoxContainer/LineEdit.text = ""
		if current_question < 10:
			next_equation()
		else:
			if testing:
				next_equation()
			else:
				GameState.in_menu = false
				open_gate.emit()
				await get_tree().create_timer(1.0).timeout
				queue_free()
		$PanelContainer/VBoxContainer/LineEdit.text = ""

func equation_solution():
	var solution
	match equation_sign:
		"+":
			solution = number1 + number2 
		"-":
			solution = number1 - number2 
		"*":
			solution = number1 * number2 
		"/":
			solution = number1 / number2 
		"^":
			solution = number1 ** number2 
	return solution
		
	
