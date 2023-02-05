extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bgcrack1 = preload("res://Sprites/bgcrack1.png")
var bgcrack2 = preload("res://Sprites/bgcrack2.png")
var bgcrack3 = preload("res://Sprites/bgcrack3.png")
var bgcrack4 = preload("res://Sprites/bgcrack4.png")
var bgcrack5 = preload("res://Sprites/bgcrack5.png")
var bgcrack6 = preload("res://Sprites/bgcrack6.png")
var bgcrack7 = preload("res://Sprites/bgcrack7.png")
var bgcrack8 = preload("res://Sprites/bgcrack8.png")
var bgcrack9 = preload("res://Sprites/bgcrack9.png")
var bgcrack10 = preload("res://Sprites/bgcrack10.png")
var bgcrack11 = preload("res://Sprites/bgcrack11.png")
var bgcrack12 = preload("res://Sprites/bgcrack12.png")
var bgcrack13 = preload("res://Sprites/bgcrack13.png")
var bgcrack14 = preload("res://Sprites/bgcrack14.png")

var bgrock_sprites = [bgcrack1, bgcrack2, bgcrack3, bgcrack4, bgcrack5, bgcrack6, bgcrack7, bgcrack8, bgcrack9, bgcrack10, bgcrack11, bgcrack12, bgcrack13, bgcrack14]
# Called when the node enters the scene tree for the first time.
func _ready():
	random_sprite()

func random_sprite():
	texture = bgrock_sprites[randi() % bgrock_sprites.size()]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
