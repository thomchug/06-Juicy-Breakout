extends Camera2D

var _decay_rate = 0.4
var _max_off = 10

var _start_pos
var _trauma = 0.0

func _ready():
	_start_pos = position
	_trauma = 0.0

func _process(delta):
	if _trauma > 0:
		_decay_trauma(delta)
		_apply_shake()

func _add_trauma(amount):
	_trauma = min(_trauma + amount, 1)

func _decay_trauma(delta):
	var morph = _decay_rate * delta
	_trauma = max(_trauma - morph, 0)
	
func _apply_shake():
	var shake = _trauma * _trauma
	var oX = _max_off * shake * _get_pos_neg_scalar()
	var oY = _max_off * shake * _get_pos_neg_scalar()
	position = _start_pos + Vector2(oX, oY)

func _get_pos_neg_scalar():
	return rand_range(-1.0, 1.0)
