extends RigidBody2D
var shooting = false
var bounce = false
const speed = 400
var target
var playerpos
var startpos
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.play()

func _integrate_forces(state):
	if shooting:
		linear_velocity = startpos.direction_to(playerpos).normalized() * speed

func shoot(player):
	target = player
	playerpos = player.global_position
	startpos = global_position
	shooting =  true
	look_at(playerpos)
	await get_tree().create_timer(1.5).timeout
	queue_free()


func _on_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		body.hurt(global_position)
