extends Path2D
var tween
var touching = false
var reversing = false
var player = null

@export var snowball : Sprite2D
@export var Area2d : Area2D
const xvalueofsneoman = 38975
const maxyvalueofsneoman =  0

var hit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($"PathFollow2D", "progress_ratio",1, 1)  
	await get_tree().create_timer(10).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if snowball.global_position.x > xvalueofsneoman:
		if snowball.global_position.y > maxyvalueofsneoman:
			if hit == false:
				hit = true
				get_parent().get_node("Sneoman").hit()
		queue_free()
	if player != null:
		if player.instashield and Area2d.Ininstashield and not reversing:
				reverse()
				reversing = true
				snowball.reparent(self,true)
	if reversing:
		snowball.position.x += 10


func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or  body.name == "Sonic":
		print("HOL UP KIDDO")
		touching = true
		player = body
		if body.animsprite.animation == "jump":
			pass
		else:
			body.hurt(global_position)

func reverse():
	tween.stop()
	
func _on_area_2d_body_exited(body):
	if body.name == "Marsh" or body.name == "Sonic":
		touching = false
