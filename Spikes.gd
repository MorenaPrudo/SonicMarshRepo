extends AnimatableBody2D
@export_enum("movable","unmovable" ) var type
@export_enum("up","right", "down","left") var spikerotation
@export var movedistance : int = 40
@export var movetime : float = 1
@export var waittime : float = 1
@onready var UiControl = $"../../CanvasLayer/ActUIController"
func _ready():
	rotation = spikerotation * PI/2
	if type == 0:
		if spikerotation == 1 or spikerotation == 3:
			tweenleft()
		else:
			tweendown()


func tweenleft():
	var tweend = create_tween() 
	tweend.set_ease(Tween.EASE_OUT)
	tweend.set_trans(Tween.TRANS_SINE)
	tweend.tween_property(self, "position:x",position.x - movedistance, movetime)  
	await tweend.finished
	if spikerotation == 1:
		await get_tree().create_timer(waittime).timeout
	tweenright()

func tweenright():
	var tweenf = create_tween() 
	tweenf.set_ease(Tween.EASE_IN_OUT)
	tweenf.set_trans(Tween.TRANS_LINEAR)
	tweenf.tween_property(self, "position:x",position.x + movedistance,movetime)  
	await tweenf.finished
	if spikerotation == 3:
		await get_tree().create_timer(waittime).timeout
	tweenleft()

func tweenup():
	var tweend = create_tween() 
	tweend.set_ease(Tween.EASE_OUT)
	tweend.set_trans(Tween.TRANS_SINE)
	tweend.tween_property(self, "position:y",position.y - movedistance, movetime)  
	await tweend.finished
	if spikerotation == 0:
		await get_tree().create_timer(waittime).timeout
	tweendown()
	
func tweendown():
	var tweend = create_tween() 
	tweend.set_ease(Tween.EASE_OUT)
	tweend.set_trans(Tween.TRANS_SINE)
	tweend.tween_property(self, "position:y",position.y + movedistance, movetime)  
	await tweend.finished
	if spikerotation == 2:
		await get_tree().create_timer(waittime).timeout
	tweenup()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		body.hurt(global_position)
		if UiControl.rings == 0:
			$"../../Audio/DeathSpike".play()
		print("death by spike")
