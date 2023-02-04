extends KinematicBody2D

export var speed = 250
export (float, 0, 1.0) var air_friction = 1.0
export (float, 0, 1.0) var acceleration = 0.3
export var jump_speed = -300
export var wall_slide_speed = 100
export var gravity = 1000
var velocity = Vector2(-10, 0)

func get_input():
	var dir = 0
	if Input.is_action_pressed('ui_right'):
		dir += 1
	if Input.is_action_pressed('ui_left'):
		dir -= 1
	if Input.is_action_just_pressed("ui_r"):
		position = Vector2(343, 4)
	if dir:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	elif is_on_wall():
		velocity.x = lerp(velocity.x, sign(velocity.x) * 0.1, 1)
	elif velocity.x:
		velocity.x = lerp(velocity.x, 0, air_friction)
		
func game_over():
	queue_free()

func _physics_process(delta):
	var on_wall = false
	get_input()
	on_wall = is_on_wall()
	
	$AnimatedSprite.animation = "Standing"
	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "rock":
			game_over()
	if on_wall:
		velocity.y = wall_slide_speed
		if Input.is_action_just_pressed("ui_select"):
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision.normal.x < 0:
					velocity = Vector2(-500, -400)
				if collision.normal.x > 0:
					velocity = Vector2(500, -400)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.normal.x < 0:
				$AnimatedSprite.animation = "Hanging"
				$AnimatedSprite.flip_h = false
				if Input.is_action_just_pressed("ui_x"):
					position.x += 15
					velocity.x = -velocity.x
			elif collision.normal.x > 0:
				$AnimatedSprite.animation = "Hanging"
				$AnimatedSprite.flip_h = true
				if Input.is_action_just_pressed("ui_x"):
					position.x -= 15
					velocity.x = -velocity.x
	else:
		if velocity.y < 500:
			velocity.y += gravity * delta
		if is_on_floor():
			$AnimatedSprite.animation = "Standing"
		else:
			$AnimatedSprite.animation = "Falling"
	move_and_slide(velocity, Vector2.UP)
	
