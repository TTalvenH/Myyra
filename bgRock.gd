extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bgrock1 = preload("res://Sprites/bgrock1.png")
var bgrock2 = preload("res://Sprites/bgrock2.png")
var bgrock3 = preload("res://Sprites/bgrock3.png")
var bgrock4 = preload("res://Sprites/bgrock4.png")
var bgrock5 = preload("res://Sprites/bgrock5.png")

var bgrock_sprites = [bgrock1, bgrock2, bgrock3, bgrock4, bgrock5]
# Called when the node enters the scene tree for the first time.
func _ready():
	random_sprite()

func random_sprite():
	texture = bgrock_sprites[randi() % bgrock_sprites.size()]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
