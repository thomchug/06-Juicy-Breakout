extends RigidBody2D

onready var Game = get_node("/root/Game")
onready var Camera = get_node("/root/Game/Camera")
onready var Starting = get_node("/root/Game/Starting")

onready var Slap = get_node("/root/Game/Slap")

var _decay_rate = 2
var _max_off = 4
var _collide_color = Color(1,1,1,1)
var _start_size
var _start_pos
var _collide = 0.0
var _rotate = 0
var _rotate_speed = 0.05
var _color = 0.0
var _color_decay = 5
var _normal_color


func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	_start_pos = $ColorRect.rect_position
	_normal_color = $ColorRect.color

func _process(delta):
	if _collide > 0:
		_decay(delta)
		_apply_shake()
	if _color > 0:
		_decay_color(delta)
		_apply_color()
	if _color == 0 and $ColorRect.color != _normal_color:
		$ColorRect.color = _normal_color

func _physics_process(delta):
	# Check for collisions
	var bodies = get_colliding_bodies()
	for body in bodies:
		Camera._add_trauma(0.3)
		_add_trauma(2.0)
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			add_color(3.0)
			Slap.playing = true
			body.queue_free()
		
		
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()

func add_color(amount):
	_color += amount

func _apply_color():
	var a = min(1, _color)
	$ColorRect.color = _normal_color.linear_interpolate(_collide_color, a)

func _decay_color(delta):
	var morph = _color_decay * delta
	_color = max(_color - morph, 0)

func _add_trauma(amount):
	_collide = min(_collide + amount, 1)

func _decay(delta):
	var morph = _decay_rate * delta
	_color = max(_collide - morph, 0)
	
func _apply_shake():
	var shake = _collide * _collide
	var oX = _max_off * shake * _get_pos_neg_scalar()
	var oY = _max_off * shake * _get_pos_neg_scalar()
	$ColorRect.rect_position = _start_pos + Vector2(oX, oY)

func _get_pos_neg_scalar():
	return rand_range(-1.0, 1.0)
	
