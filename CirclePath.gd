extends Path2D

const size = 100
const points = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	curve = Curve2D.new()
	for i in points:
		curve.add_point(Vector2(0, -size).rotated((i / float(points)) * TAU))
	curve.add_point(Vector2(0, -size))
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($"PathFollow2D", "progress_ratio",1, 5)  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
