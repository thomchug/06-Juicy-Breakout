extends KinematicBody2D

onready var _shape = $ColorRect.get_rect().size
onready var _view = get_viewport().get_visible_rect().size
onready var _collide_transform = $CollisionShape2D.get_transform().get_scale()

export var distortX = 3.0
export var distortY = 1.5

var _target = position

func _ready():
	set_process(true)
	position.y = -50
	$Tween.interpolate_property(self, "position", position, _target, 1.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()

func _physics_process(delta):
	var shape = $ColorRect.get_rect().size
	var view = get_viewport().get_visible_rect().size
	var target = get_viewport().get_mouse_position().x
	if target < shape.x / 2:
		target = shape.x / 2
	if target > view.x - shape.x / 2:
		target = view.x - shape.x / 2
	
	#paddle stretch
	if target != position.x:
		var x = position.x + ((target - position.x)*0.2)
		var wid = 1 + (distortX * (abs(target-position.x)/_view.x))
		var hei = 1 - (1/distortY * (abs(target - position.x)/_view.y))
		_change_size(wid, hei)
		position = Vector2(x, position.y)
	else:
		_change_size(1,1)

func _change_size(w, h):
	$ColorRect.rect_scale = Vector2(w, h)
	$CollisionShape2D.set_scale(Vector2(_collide_transform.x*w, _collide_transform.y*h))
