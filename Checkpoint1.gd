extends Area2D
@onready var anim = $starpost
var checkedpoint = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if !checkedpoint:
			anim.play("activate")
			$"../Audio/Checkpoint".play()
			Global.checkpointposition = global_position
			checkedpoint = true
