extends Node3D

func _ready():
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		print("Back pressed (right-click equivalent)")
		get_viewport().set_input_as_handled()
		
		# Call your own logic here instead of open_menu()
		handle_back()

func handle_back():
	print("Handle back action here (open menu, pause, etc.)")
