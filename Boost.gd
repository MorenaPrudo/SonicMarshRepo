extends Node2D
@export var forwardboost = 700
@export var upwardboost = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		body.animsprite.play("antigravitymotion")
		body.lockdirection(false,0.1)
		body.speed = forwardboost
		body.velocity.y -= upwardboost
