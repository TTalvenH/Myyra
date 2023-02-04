extends Node2D

var carrot_spd_max = 350.0
var carrot_spd_min = 250.0
var beet_spd_min = 150.0
var beet_spd_max = 250.0

var level = 1
var levelmobs = 5
var mobsspawned = 0
var mobsperlevel = 1
var bosstimer = 15.0
var fulltimer = 3.0
var decrease = 0.25

func _ready():
	$Mobtimer.wait_time = fulltimer
	$Mobtimer.start()

func increase_timer():
	if (mobsspawned < levelmobs):
		$Mobtimer.stop()
		$Mobtimer.wait_time = fulltimer - ((fulltimer/1.5) * (float(mobsspawned)/levelmobs))
		$Mobtimer.start()
		mobsspawned += 1
	else:
		$Mobtimer.stop()
		$Mobtimer.wait_time = bosstimer - (decrease * level)
		$Mobtimer.start()
		mobsspawned = 0
		levelmobs += mobsperlevel
		mobsperlevel += 1
		fulltimer -= decrease
		level += 1
		print (level)
	print ($Mobtimer.wait_time)

func _on_Mobtimer_timeout():
	increase_timer()
	spawnEnemy()
	var adds = level
	while (adds > 3):
		spawnEnemy()
		adds -= 3

func spawnEnemy():
	var rand = RandomNumberGenerator.new()
	var screen_size = get_viewport().get_visible_rect().size
	var enemyscene
	var enemy
	var direction
	var velocity
	var vegtype = randi()%3
	#increase_timer()
	if (level > 1 and mobsspawned == 0):
		enemyscene = load("res://RootBoss.tscn")
		enemy = enemyscene.instance()
		enemy.position.y = -200
		enemy.position.x = screen_size.x/2 - 125
		direction = 0
		enemy.linear_velocity = Vector2(0, 50 + (level * 10))
		add_child(enemy)
		return
	if (vegtype == 2):
		enemyscene = load("res://Potato.tscn")
	else:
		enemyscene = load("res://RootVeg.tscn")
	enemy = enemyscene.instance()
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
			enemy.position.x = screen_size.x + 30
			direction = -PI /2
		enemy.position.y = rand_range(screen_size.y/8, (screen_size.y * 3)/4)
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
		elif (enemy.position.x > 0):
			enemy._direction = 0 
			enemy.get_node("Potato").play("", true)
	add_child(enemy)
