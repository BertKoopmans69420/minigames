class_name BreakoutSafeFloor extends StaticBody2D

var safety:int = 3

func hit():
	safety -= 1
	match safety:
		2: 
			$SingleColor.modulate = Color(1, 0.5, 0, 1)
		1:
			$SingleColor.modulate = Color(1, 0, 0, 1)
		0:
			queue_free()
