extends Node2D

export var speed = 120
var screen_size

# number of screen heights in texture height
var texture_size = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y -= speed
	if position.y < screen_size.y * texture_size * -1:
		position.y = 0
	position += velocity * delta
