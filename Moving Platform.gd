extends Path2D
const  time = 3
@onready var pathfollow = $PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready():
	tweenfirst()
	
func tweenfirst():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(pathfollow, "progress_ratio",1, time)
	await tween.finished
	tweensecond()

func tweensecond():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(pathfollow, "progress_ratio",0, time)
	await tween.finished
	tweenfirst()
