extends KinematicBody2D

export var speed = 250
export (float, 0, 1.0) var air_friction = 1.0
export (float, 0, 1.0) var acceleration = 0.3
export var jump_speed = -300
export var wall_slide_speed = 100
export var gravity = 1500
var velocity = Vector2(-10, 0)
signal paused
signal game_over

var jumpsound1 = preload("res://Sounds/jump1.ogg")
var jumpsound2 = preload("res://Sounds/jump2.ogg")
var jumpsound3 = preload("res://Sounds/jump3.ogg")
var jumpsound4 = preload("res://Sounds/jump4.ogg")
var jump_sounds = [jumpsound1, jumpsound2, jumpsound3, jumpsound4]

var turnsound1 = preload("res://Sounds/turn1.ogg")
var turnsound2 = preload("res://Sounds/turn2.ogg")
var turnsound3 = preload("res://Sounds/turn3.ogg")
var turn_sounds = [turnsound1, turnsound2, turnsound3]

func get_input():
	var dir = 0
	if Input.is_action_pressed("open_menu"):
		get_tree().paused = true
		emit_signal("paused")
	if Input.is_action_pressed('ui_right') and !is_on_wall():
		dir += 1
	if Input.is_action_pressed('ui_left') and !is_on_wall():
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
	if on_wall:
		velocity.y = wall_slide_speed
		if Input.is_action_pressed("ui_up"):
			velocity.y = wall_slide_speed / 10
		if Input.is_action_pressed("ui_down"):
			velocity.y = wall_slide_speed * 3
		if Input.is_action_just_pressed("ui_select"):
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision.normal.x < 0:
					velocity = Vector2(-300, -450)
				if collision.normal.x > 0:
					velocity = Vector2(300, -450)
			$AudioStreamPlayer.set_stream(jump_sounds[randi() % jump_sounds.size()])
			$AudioStreamPlayer.play()
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.normal.x < 0:
				$AnimatedSprite.animation = "Hanging"
				$AnimatedSprite.flip_h = false
				if Input.is_action_pressed("ui_right"):
					position.x += 15
					velocity.x = -velocity.x
					$AudioStreamPlayer.set_stream(turn_sounds[randi() % turn_sounds.size()])
					$AudioStreamPlayer.play()
			elif collision.normal.x > 0:
				$AnimatedSprite.animation = "Hanging"
				$AnimatedSprite.flip_h = true
				if Input.is_action_pressed("ui_left"):
					position.x -= 15
					velocity.x = -velocity.x
					$AudioStreamPlayer.set_stream(turn_sounds[randi() % turn_sounds.size()])
					$AudioStreamPlayer.play()
	else:
		if velocity.y < 700:
			velocity.y += gravity * delta
		if is_on_floor():
			$AnimatedSprite.animation = "Standing"
		else:
			$AnimatedSprite.animation = "Falling"
	move_and_slide(velocity, Vector2.UP)
	


func _on_Area2D_body_entered(body):
		emit_signal("game_over")
