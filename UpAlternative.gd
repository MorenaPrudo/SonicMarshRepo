extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_body_exited(body):
	if body is CharacterBody2D:
		if body.jumping:
			print("hirfgg")
			await get_tree().create_timer(0.4).timeout
			body.onup = false
			body.animsprite.rotation = 0
			body.up_direction = Vector2(0,-1)
			body.get_node("CollisionShape2D").rotation = 0
		else:
			print("hirfdddddddddddgg")
			body.onup = false
			body.animsprite.rotation = 0
			body.up_direction = Vector2(0,-1)
			body.get_node("CollisionShape2D").rotation = 0
			if body.spring:
				body.velocity.y -= 1000


func _on_start_body_entered(body):
	print("should work")
	if body is CharacterBody2D:
		body.spring = false
		body.animsprite.rotation = PI/2
		body.up_direction = Vector2(1,0)
		body.get_node("CollisionShape2D").rotation = PI/2
		body.onup = true
