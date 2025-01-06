extends Node2D
@export var Floor : StaticBody2D
@export var Floor2 : CollisionPolygon2D
@export var Floor3 : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_on_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		Floor3.set_deferred("disabled",true)
		Floor.get_child(0).set_deferred("disabled",false)


func _on_off_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		Floor.get_child(0).set_deferred("disabled",true)
		Floor2.set_deferred("disabled",true)
		print("off")
