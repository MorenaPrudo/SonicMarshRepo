extends Path2D
const range = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	curve = Curve2D.new()
	curve.add_point(Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(body):
	#await get_tree().create_timer(0.1).timeout
	curve.add_point(global_position.direction_to(body.global_position) * range)     
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($"PathFollow2D", "progress_ratio",1, 1)  
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		body.hurt(global_position)
