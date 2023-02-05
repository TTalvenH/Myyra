extends Node2D

export var speed = 120
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	$Sprite.flip_h = randf() > 0.5
	position.y = screen_size.y * randf()
	position.x = screen_size.x * randf()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < $Sprite.texture.get_height() * -1:
		if $Sprite.has_method("random_sprite"):
			$Sprite.random_sprite()
		$Sprite.flip_h = randf() > 0.5
		position.y = screen_size.y * (1 + rand_range(0, 2)) + $Sprite.texture.get_height() / 2
		position.x = screen_size.x * randf()
	#	$Sprite.scale.x = randf()
	#	$Sprite.scale.y = $Sprite.scale.x
	var velocity = Vector2.ZERO
	velocity.y -= speed
	position += velocity * delta
