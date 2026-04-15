extends Button
@onready var creds_txt = $"../creds_text"
signal count_changed(newvalue)
var trigg: bool = false

var trigger:
	get:
		return trigg
	set(value):
		trigg = value
		count_changed.emit(trigg)
		if creds_txt.visible == false:
			creds_txt.visible = true
			visible = false
			await wait(2) # like wait(2) in rblx
			creds_txt.visible = false
			visible = true
		elif creds_txt.visible == true:
			return

func wait(sec): # universal wait function
	await get_tree().create_timer(2).timeout

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	trigger = !trigger
	print("presses")
