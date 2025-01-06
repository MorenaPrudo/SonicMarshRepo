extends Sprite2D
const speed = 2
var tweendistance = -500
var canhurt = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position",position + Vector2(tweendistance,0), speed)
	await tween.finished
	queue_free() 


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and canhurt:
		body.hurt(global_position)

