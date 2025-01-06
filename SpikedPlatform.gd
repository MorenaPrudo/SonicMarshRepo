extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		body.hurt(global_position)
		
func arise():
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position",position + Vector2(0,-117), 2)
	await tween.finished
	$Hitbox.set_deferred("monitoring",true)
	
func burial():
	$Hitbox.set_deferred("monitoring",false)
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position",position + Vector2(0,117), 2)
	await tween.finished
