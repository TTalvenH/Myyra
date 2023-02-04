extends Node2D



func _on_Mobtimer_timeout():
	var rand = RandomNumberGenerator.new()
	var Enemyscene = load("res://Enemy.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	
	var enemy = Enemyscene.instance()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	rand.randomize()
	var y = 10
	
	enemy.position.y = y
	enemy.position.x = x
	add_child(enemy)
