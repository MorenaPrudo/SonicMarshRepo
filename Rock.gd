extends RigidBody2D
@export_enum("Pushable","Breakable") var type
@export var startmarker : Marker2D
@export var endmarker : Marker2D
var onrock = false
var broken = false
var player
var startpos
var endpos
var speed = false
var spindashrock = false
# Called when the node enters the scene tree for the first time.
func _ready():
	startpos = startmarker.global_position.x
	endpos = endmarker.global_position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if onrock:
		if type == 0:
			if player.animsprite.animation == "pushing":
				if player.currentdirection ==1:
					if global_position.x < endpos:
						linear_velocity.x = 50 * player.currentdirection
				else:
					if global_position.x > startpos:
						linear_velocity.x = 50 * player.currentdirection
		else:
			if (spindashrock or player.jumping or player.global_position.y < global_position.y - 5):
				onrock = false
				free()
				if spindashrock:
					player.speed = speed
				
						
func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		onrock = true
		print("djdjd")
		player = body


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		onrock = false
		player = body
		print("slimette the GOAT")


func _on_spindash_area_body_entered(body):
	if body is CharacterBody2D:
		if (body.rolling and body.velocity.x > 200):
			apply_impulse(body.velocity*2)
			spindashrock = true
			speed = body.speed

func _on_spindash_area_body_exited(body):
	if body is CharacterBody2D:
		spindashrock = false
