extends Control

func _ready():
	pass # Replace with function body.


func _on_Menu_Button_pressed():
	get_tree().change_scene("res://FadeToBlack.tscn")


func _on_Menu_Button2_pressed():
	get_tree().quit()
