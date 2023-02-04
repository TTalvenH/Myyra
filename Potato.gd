extends RigidBody2D

var RotateSpeed = 6
var Radius = 20
var _centre
var _direction
var _angle = 0

func _ready():
	set_process(true)
	_centre = self.position
	#_centre.x += _direction

#func _integrate_forces(state):
#	state.linear_velocity = Vector2(50, 0)

func set_direction(direction):
	_direction = direction

func _process(delta): 
	if (_direction == 1):
		_centre.x += rand_range(1, 3)
	else:
		_centre.x += rand_range(-1, -3)
	_angle += RotateSpeed * delta;

	var offset = Vector2(sin(_angle), cos(_angle)) * Radius;
	var pos = _centre + offset
	self.position = pos
