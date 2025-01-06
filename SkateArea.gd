extends Area2D
var inskatearea = false
var player
@export var angles : PackedInt64Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inskatearea:
		var numofpoints = angles.size()
		for point in range(numofpoints):
			if player.global_position.x > get_child(angles.size() - point).global_position.x:
				player.animsprite.rotation = deg_to_rad(angles[angles.size()-1 - point])
				break

func _on_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		inskatearea = true
		body.longdeccel = true
		player = body
		body.animsprite.play("skateline")
	

func _on_body_exited(body):
	if body is CharacterBody2D:
		inskatearea = false
		body.rotation = 0
		body.animsprite.play("run")
		body.longdeccel = false
