extends Node2D

var carrot_spd_max = 350.0
var carrot_spd_min = 250.0
var beet_spd_min = 150.0
var beet_spd_max = 250.0

func _on_Mobtimer_timeout():
	var rand = RandomNumberGenerator.new()
	var screen_size = get_viewport().get_visible_rect().size
	var enemyscene
	var direction
	var vegtype = randi()%3
	if (vegtype == 2):
		enemyscene = load("res://Potato.tscn")
	else:
		enemyscene = load("res://RootVeg.tscn")
	var enemy = enemyscene.instance()
	if (vegtype < 2):
		enemy.settype(vegtype)
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = 10
		enemy.position.y = y
		enemy.position.x = x
	else:
		rand.randomize()
		if (randi()%2 == 0):
			enemy.position.x = -30
			direction = PI /2
		else:
			enemy.position.x = screen_size.x - 60
			direction = -PI /2
		enemy.position.y = rand_range(screen_size.y/8, (screen_size.y * 3)/4)
	var velocity
	if (vegtype == 0):
		if (enemy.position.x > (screen_size.x / 2)):
			direction = rand_range(PI / 8, PI / 4)
		else:
			direction = rand_range(-PI / 4, -PI / 8)
		velocity = Vector2(0, rand_range(beet_spd_min, beet_spd_max))
		enemy.linear_velocity = velocity.rotated(direction)
	elif (vegtype == 1):
		direction = 0
		velocity = Vector2(0, rand_range(carrot_spd_min, carrot_spd_max))
		enemy.linear_velocity = velocity.rotated(direction)
	elif (vegtype == 2):
		if (enemy.position.x < 0):
			enemy._direction = 1
			enemy.get_node("Potato").flip_v = true
			enemy.get_node("Potato").play("", true)
		elif (enemy.position.x > 0):
			enemy._direction = 0 
			enemy.get_node("Potato").play("", true)
	add_child(enemy)
