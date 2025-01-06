extends Camera2D
var followy = false
var player
const step = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followy:
		global_position.y = lerp(global_position.y,player.global_position.y,step)
		

func locktoplayery(target):
	player = target
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "offset",Vector2(0,-50), 5)
	followy = true
	
func unlocktoplayery():
	followy = false
