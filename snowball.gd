extends RigidBody2D
var shooting = false
var bounce = false
const speed = 600
var target
var playerpos
var startpos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _integrate_forces(state):
	if shooting:
		linear_velocity = startpos.direction_to(playerpos).normalized() * speed

func shoot(player):
	target = player
	playerpos = player.global_position
	startpos = global_position
	shooting =  true
	await get_tree().create_timer(3).timeout
	queue_free()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		body.hurt(global_position)
