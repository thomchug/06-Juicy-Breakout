extends StaticBody2D

var points = 10
onready var target = position
onready var i = $Timer

func _ready():
	position.y = -70
	var tick = rand_range(0, 1.5)
	i.set_wait_time(tick)
	i.start()
	yield(i, "timeout")
	$Tween.interpolate_property(self, "position", position, target, 2.0, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
