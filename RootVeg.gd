extends RigidBody2D

func settype(type):
	 vegtype = type

func _ready():
	var rootvegtype = randi()%3
	if (rootvegtype == 1):
		$Beet.playing = true
		$Carrot.playing = false
		$Carrot.visible = false
		$Potato.visible = false
		$Potato.playing = false
		$BeetCollision.disabled = false
	elif (rootvegtype == 2):
		$Beet.playing = false
		$Beet.visible = false
		$Carrot.playing = true
		$Potato.visible = false
		$Potato.playing = false
		$CarrotCollision.disabled = false
	elif (rootvegtype == 0):
		$Beet.playing = false
		$Beet.visible = false
		$Carrot.playing = false
		$Carrot.visible = false
		$Potato.visible = true
		$Potato.playing = true
		$PotatoCollision.disabled = false
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
