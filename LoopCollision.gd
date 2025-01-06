extends StaticBody2D
@onready var RightCollision = $RightCollision
@onready var LeftCollision = $LeftCollision
@export var loop : PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_right_area_body_entered(body):
		if body.name == "Marsh" or body.name == "Sonic":
			set_left_off()
	
func _on_left_area_body_entered(body):
		if body.name == "Marsh" or body.name == "Sonic":
			set_right_off()

func set_left_off():
		RightCollision.set_deferred("disabled",false)
		LeftCollision.set_deferred("disabled",true)

func set_right_off():
		print("mwc")
		RightCollision.set_deferred("disabled",true)
		LeftCollision.set_deferred("disabled",false)

func _on_finish_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		print("???????????????")
		if loop.leavingright:
			set_right_off()
			print("rightoff!!!!!!!!!!!!!!!")
	



func _on_finish_2_body_entered(body):
	print("yooo")
	print(loop.leavingright)
	if body.name == "Marsh" or body.name == "Sonic":
		if !loop.leavingright:
			set_left_off()
			print("leftoff!!!!!!!!!!!!!!!")
