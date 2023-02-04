extends Node2D

var root_spd_max = 300.0
var root_spd_min = 200.0

func _on_Mobtimer_timeout():
    var rand = RandomNumberGenerator.new()
    var Enemyscene = load("res://RootVeg.tscn")
    var screen_size = get_viewport().get_visible_rect().size

    var enemy = Enemyscene.instance()
    rand.randomize()
    var x = rand.randf_range(0, screen_size.x)
    rand.randomize()
    var y = 10

    enemy.position.y = y
    enemy.position.x = x
    var direction
    if (enemy.position.x > (screen_size.x / 2)):
        direction = rand_range(0, PI /4)
    else:
        direction = rand_range(-PI / 4, 0)
    var velocity = Vector2(0, rand_range(root_spd_min, root_spd_max))
    enemy.linear_velocity = velocity.rotated(direction)
    add_child(enemy)

#func _on_Mobtimer_timeout():
#	var rand = RandomNumberGenerator.new()
#	var Enemyscene = load("res://Enemy.tscn")
#	var screen_size = get_viewport().get_visible_rect().size
#	
#	var enemy = Enemyscene.instance()
#	rand.randomize()
#	var x = rand.randf_range(0, screen_size.x)
#	rand.randomize()
#	var y = 10
#	
#	enemy.position.y = y
#	enemy.position.x = x
#	add_child(enemy)

