extends Button
@onready var my_label = $"../Label" 
@onready var wot = $"../type"
signal count_changed(new_value)

var what : String = ""

var count = 1:
	set(value):
		count = value
		count_changed.emit(count) 
		if my_label:
			wot.text = str(what)
			my_label.text = str(count)

func _ready() -> void:
	mouse_entered.connect(_mouse_enter)
	mouse_exited.connect(_mouse_exit)
	button_down.connect(_click)
	button_up.connect(_click_off)
	
func _mouse_enter():
	what = str("Mouse Enter +1")
	count += 1
	print("buh") #when mouse entered

func _mouse_exit():
	what = str("Mouse Exit +1")
	count += 1
	print("IT ENTERED")

func _click():
	what = str("Mouse Click +1")
	count += 1
	print("Button was clicked")
	
func _click_off():
	what = str("Mouse Click End +1")
	count += 1
	print("clicking was done")
