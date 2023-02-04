extends RigidBody2D

var vegtype

func settype(type):
	 vegtype = type

func _ready():
	if (vegtype == 0):
		$Beet.playing = true
		$Carrot.playing = false
		$Carrot.visible = false
		$Potato.visible = false
		$Potato.playing = false
		$BeetCollision.disabled = false
	elif (vegtype == 1):
		$Beet.playing = false
		$Beet.visible = false
		$Carrot.playing = true
		$Potato.visible = false
		$Potato.playing = false
		$CarrotCollision.disabled = false
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
