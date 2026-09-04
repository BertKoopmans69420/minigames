class_name SpeedTyping extends Node2D

var time_running:bool = false
var time:float = 0.0
var record_timehe:float = 15.054
var record_timenl:float = 4.756
var goal:Label
var lang:String
@onready var lineedit:LineEdit =$Control/LineEdit
@onready var timer:Label =$Control/time
@onready var record_timer:Label =$Control/record_timehe
@onready var record_timer2:Label =$Control/record_timenl


var hebrew_list:Array = ["אבגדהוזחטיכלמנסעפצקרשתךםןףץ", "אני אוהב לאכול פיצה", "הכלב רץ בפארק", "היום קר מאוד בחוץ", "אני גר בירושלים", "הבית שלי גדול", "אני שותה קפה בבוקר", "יש לי חבר טוב", "הילדה קוראת ספר", "אנחנו הולכים לים", "הוא אוכל פיצה בבית", "אני לומד עברית היום", "השמש זורחת בחוץ", "יש לי אחות אחת", "אמא מבשלת ארוחת ערב", "הם משחקים כדורגל", "אני אוהב מוזיקה טובה", "הספר שלי על השולחן", "היא שרה שיר יפה", "אנחנו אוכלים ביחד", "הלילה יהיה קר מאוד", "אבא קורא עיתון בבית", "יש לי כלב קטן", "אני הולך לבית ספר", "המים קרים מאוד היום", "היא גרה בתל אביב"]
var dutch_list:Array = ["abcdefghijklmnopqrstuvwxyz", "ik hou van pizza eten", "de hond rent in het park", "het is vandaag heel koud buiten", "ik woon in Nederland", "mijn huis is groot", "ik drink koffie in de ochtend", "ik heb een goede vriend", "het meisje leest een boek", "wij gaan naar de zee", "hij eet pizza in huis", "ik leer vandaag Nederlands", "de zon schijnt buiten", "ik heb een zus", "mama kookt het avondeten", "zij spelen voetbal", "ik hou van goede muziek", "mijn boek ligt op de tafel", "zij zingt een mooi lied", "wij eten samen", "de nacht wordt heel koud", "papa leest de krant thuis", "ik heb een kleine hond", "ik ga naar school", "het water is vandaag heel koud", "zij woont in Amsterdam"] 
func _ready():
	_on_he_pressed()
	lineedit.grab_focus()
	record_timer.text = str(record_timehe)
	record_timer2.text = str(record_timenl)

func _process(delta):
	if Input.is_action_just_released("Speed Typing start timer"):
		start_timer()
	if time_running:

		time += delta
		if int(timer.text) != floori(time):
			set_time(floori(time))


func _on_line_edit_text_submitted(_new_text):
	check()
	reset()

func check():
	if lineedit.text.strip_edges() == goal.text.strip_edges():
		set_time(floor(time * 1000) / 1000.0)
		if lang == "he":
			if floor(time * 1000) / 1000.0 < record_timehe:
				record_timehe = floor(time * 1000) / 1000.0
				record_timer.text = str(record_timehe)
		if lang == "nl":
			if floor(time * 1000) / 1000.0 < record_timenl:
				record_timenl = floor(time * 1000) / 1000.0
				record_timer2.text = str(record_timenl)
	else:
		set_time(0)
		time = 0.0
	time_running = false
	
func start_timer():
	time_running = true
	set_time(0)
	time = 0.0
	lineedit.grab_focus()
func reset():
	lineedit.clear()
func set_time(tim):
	$Control/time.text = str(tim)


func _on_he_pressed():
	lang = "he"
	goal = $Control/goalhe
	goal.text = hebrew_list[randi_range(0, len(hebrew_list) - 1)]
	goal.visible = true
	record_timer.visible = true
	record_timer2.visible = false
	$Control/goalnl.visible = false
	

func _on_nl_pressed():
	lang = "nl"
	goal = $Control/goalnl
	goal.text = dutch_list[randi_range(0, len(dutch_list) - 1)]
	goal.visible = true
	record_timer2.visible = true
	record_timer.visible = false
	$Control/goalhe.visible = false
