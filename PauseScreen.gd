extends Control

func _ready():
	pass

func _on_quit_button_pressed():
	get_tree().quit()


func _on_Continue_button_pressed():
	self.visible = false
	get_tree().paused = false


func _on_Player_paused():
	self.visible = true
