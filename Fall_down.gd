extends KinematicBody2D

func _ready():
	var velocity = Vector2()
func _physics_process(delta):
	var gravity = 100
	position.y += gravity * delta
