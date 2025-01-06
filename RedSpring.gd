extends RigidBody2D
@export var bouncestrength : int
@export_enum("Up", "Down", "Left", "Right") var bounceDirection

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		$"../../Audio/Spring".play()
		add_velocity(body)

func add_velocity(body): #0 is up; 1 is down: 2 is left; 3 is right
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()
	if bounceDirection == 0:
		body.velocity.y = -bouncestrength
	
		await get_tree().create_timer(.05).timeout
		body.jumping = true
		body.spring = true
		body.animsprite.animation = "antigravitymotion"
		body.animsprite.play()
		
	if bounceDirection == 1:
		body.velocity.y += bouncestrength
	
		await get_tree().create_timer(.05).timeout
		body.jumping = true
		body.spring = true
		body.animsprite.animation = "antigravitymotion"
		body.animsprite.play()
	
	if bounceDirection == 2:
		if body.onup:
			body.spring = true
			body.lockdirection(true,0.3)
			body.velocity.x -= bouncestrength * 2
			body.animsprite.animation = "antigravitymotion"
		else:
			body.spring = true
			body.lockdirection(true,0.3)
			body.speed = 1000
			if body.jumping:
				body.animsprite.animation = "jump"
			else:
				body.animsprite.animation = "fullspeed"
			body.animsprite.play()

	if bounceDirection == 3:
		if body.onup:
			body.spring = true
			body.lockdirection(true,0.3)
			body.velocity.x += bouncestrength * 2
			body.animsprite.animation = "antigravitymotion"
		else:
			body.spring = true
			body.lockdirection(true,0.3)
			body.speed = 1000
			if body.jumping:
				body.animsprite.animation = "jump"
			else:
				body.animsprite.animation = "fullspeed"
			body.animsprite.play()
