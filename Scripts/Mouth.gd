extends Sprite
onready var s = scale

func _ready():
	pass
func _process(delta):
	var target = get_node("/root/Game/Ball")
	if target:
		var dist = (get_global_position().y - target.get_position().y)/get_viewport().size.y
		dist -= 0.3
		scale.y = s.y * dist
	else:
		scale = s
