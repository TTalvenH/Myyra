extends Area2D

func _process(delta):
	var list = get_overlapping_bodies()
	print(list)
