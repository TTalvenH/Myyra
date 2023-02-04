extends Node2D

export var speed = 150
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	position.y = screen_size.y * (1 + randf())
	position.x = randf() * screen_size.x
#	$Sprite.scale.x = randf()
#	$Sprite.scale.y = $Sprite.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y -= 1 * speed
	if position.y < 0:
		position.y = screen_size.y * (1 + randf())
		position.x = randf() * screen_size.x
	#	$Sprite.scale.x = randf()
	#	$Sprite.scale.y = $Sprite.scale.x
	position += velocity * delta
