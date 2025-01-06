extends Path2D
# initial pos - x 0,  y -9

func _ready():
	#await get_tree().create_timer(1).timeout
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($"PathFollow2D", "progress_ratio",1, 1)  
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Sonic" or body.name == "Marsh":
		body.hurt(global_position)
