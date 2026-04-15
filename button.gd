extends Button

@onready var my_label = $"../Label"
@onready var wot = $"../type"
@onready var manager = $"../"

signal count_changed(new_value)

var what: String = ""
var strngt : float = 1.0

var _count := 1
var count:
	get:
		return _count
	set(value):
		_count = value
		count_changed.emit(_count)

		if my_label:
			my_label.text = str(_count)
			pop_label()
			manager.set_effect(manager.Effect.shake, strngt)

			if _count == 50:
				tween_color(0.9,0.0,0.0)
				#manager.set_effect(manager.Effect.wave, strngt)

			if _count == 100:
				tween_color(0.7,0.0,0.0)
				#manager.set_effect(manager.Effect.shake, strngt)

			if _count == 150:
				tween_color(0.5,0.0,0.0)
				#manager.set_effect(manager.Effect.rumble, strngt)

		if wot:
			wot.text = what


func _ready() -> void:
	my_label.pivot_offset = my_label.size / 2
	mouse_entered.connect(_mouse_enter)
	mouse_exited.connect(_mouse_exit)
	button_down.connect(_click)
	button_up.connect(_click_off)


func pop_label():
	if not my_label:
		return

	my_label.scale = Vector2(1, 1)

	var tween = create_tween()
	tween.tween_property(my_label, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(my_label, "scale", Vector2(1, 1), 0.15)


func set_label_color(c: Color):
	my_label.add_theme_color_override("font_color", c)


func tween_color(r, g, b):
	if not my_label:
		return

	var tween = create_tween()
	tween.tween_method(set_label_color, Color.WHITE, Color(r, g, b), 0.4)


func add_strength():
	strngt = min(strngt + 0.1, 5.0)


func _mouse_enter():
	add_strength()
	what = "Mouse Enter +1"
	count += 1


func _mouse_exit():
	add_strength()
	what = "Mouse Exit +1"
	count += 1


func _click():
	add_strength()
	what = "Mouse Click +1"
	count += 1


func _click_off():
	add_strength()
	what = "Mouse Click End +1"
	count += 1
