extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bgrock1 = preload("res://Sprites/bgrock1.png")
var bgrock2 = preload("res://Sprites/bgrock2.png")

var bgrock_sprites = [bgrock1, bgrock2]
# Called when the node enters the scene tree for the first time.
func _ready():
	random_sprite()

func random_sprite():
	texture = bgrock_sprites[randi() % bgrock_sprites.size()]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
