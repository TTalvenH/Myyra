extends ColorRect


signal fade_finished

func _ready():
	$AnimationPlayer.play("FadeToBlack")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Main.tscn")
