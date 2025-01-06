extends PathFollow2D
const  time = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	tweenfirst()
	
func tweenfirst():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "progress_ratio",1, time)
	await tween.finished
	progress_ratio = 0
	tweenfirst()
