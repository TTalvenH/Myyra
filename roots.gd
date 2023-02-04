extends Node2D

export var speed = 180
var screen_size

var connector_sprite_height = 4
var min_root_length = 200
var max_root_length = 700

func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	# taa ei tee plajoa mitaan talla hetkella, periaatteessa vaan koittaa randomoida juurten alkusijainnit
	for root in self.get_children():
		var root_height = randi() % (max_root_length - min_root_length) + min_root_length
		root.get_node("RootSprite").region_rect = Rect2(0, 0, 4, root_height)
		root.position.y = screen_size.y * rand_range(0, 3) * -1 #try to randomize start positions
		root.get_node("ConnectorSprite").position.y = -1 * (root_height / 2) - connector_sprite_height
		root.get_node("RootSprite").position.y = -1 * (root_height / 2)
		root.get_node("CollisionShape2D").shape.extents.y = root_height / 2
		
	var center_root = $Root5
	var center_root_heigt = randi() % 2000 + 9000
	center_root.get_node("RootSprite").region_rect = Rect2(0, 0, 4, center_root_heigt)
	center_root.position.y = screen_size.y * -1
	center_root.get_node("ConnectorSprite").position.y = -1 * (center_root_heigt / 2) - connector_sprite_height
	center_root.get_node("RootSprite").position.y = -1 * (center_root_heigt / 2)
	center_root.get_node("CollisionShape2D").shape.extents.y = center_root_heigt / 2
	#	connect_root(root)

func _process(delta):
	# loopataan jokainen childnode, kaikki nodet pitaa olla identtisia, paitsi transform.position maarittaa x-akselin sijainnin
	for root in self.get_children():
		
		# tassa randomisoidaan juurten sijannit y-akselilla:
		# jos juuri on mennyt oman pituusensa + random maaran ruudun ylapuolelle, if lause toteutuu
		# randi():n jalkeisilla numeroilla voi koittaa saataa randomisaatiota
		if root.position.y < root.get_node("CollisionShape2D").shape.extents.y * -2 - (randi() % 2600 + 200):
			# randomisoidaan juuren pituus
			var root_height = randi() % (max_root_length - min_root_length) + min_root_length
			root.get_node("RootSprite").region_rect = Rect2(0, 0, 4, root_height)
			root.get_node("CollisionShape2D").shape.extents.y = root_height / 2
			# siirretaan spritet oikeisiin kohtiin uuden pituisessa juuressa
			root.get_node("ConnectorSprite").position.y = -1 * (root_height / 2) - connector_sprite_height
			root.get_node("RootSprite").position.y = -1 * (root_height / 2)
			# siirretaan juurinode ruudun ylapuolelta ruudun alapuolelle
			root.position.y = screen_size.y + root_height / 2#ylapaat alkaa aina samasta kohdasta
			###root.position.y = screen_size.y + max_root_length / 2 + (max_root_length - root_height) / 2 # alapaat alkaa ain samasta kohdasta testi (ei toimi)
			# yhdistetaan ConnectorSpritella lahimpaan juureen tai ruudun reunaan
			connect_root(root)
		
		var velocity = Vector2.ZERO
		velocity.y -= speed
		root.position += velocity * delta
	
func connect_root(curr_root):
	var connector_width
	var connector_direction
	
	if (curr_root.position.x < screen_size.x / 2):
		connector_width = curr_root.position.x
		connector_direction = 'left'
	else:
		connector_width = screen_size.x - curr_root.position.x
		connector_direction = 'right'
	
	var curr_root_top_edge = curr_root.position.y - curr_root.get_node("CollisionShape2D").shape.extents.y 
	
	for root in self.get_children():
		if (curr_root.position.x != root.position.x):
			var root_bottom_edge = root.position.y + root.get_node("CollisionShape2D").shape.extents.y
			if (root_bottom_edge > curr_root_top_edge):
				if (root.position.x < curr_root.position.x):
					if (connector_width >= curr_root.position.x - root.position.x):
						connector_width = curr_root.position.x - root.position.x
						connector_direction = 'left'
				elif (root.position.x > curr_root.position.x):
					if (connector_width >= root.position.x - curr_root.position.x):
						connector_width = root.position.x - curr_root.position.x
						connector_direction = 'right'
	
	if (connector_direction == 'left'):
		curr_root.get_node("ConnectorSprite").offset.x = -2 - connector_width
	if (connector_direction == 'right'):
		curr_root.get_node("ConnectorSprite").offset.x = -2
	curr_root.get_node("ConnectorSprite").region_rect = Rect2(0, 0, 4 + connector_width, 4)

