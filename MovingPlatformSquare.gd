extends Path2D
@export var  time1 = 3
@onready var pathfollow = $PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready():
	tweenfirst()
	
func tweenfirst():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(pathfollow, "progress_ratio",1, time1)
	await tween.finished
	pathfollow.progress_ratio = 0
	tweenfirst()

