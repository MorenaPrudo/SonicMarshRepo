extends RigidBody2D
var FORCE = Vector2(900,900)
@onready var area2d = $Area2D
@onready var ringsprite = $AnimatedSprite2D
var worth : int
var cancollect = false
var start = false
var angled
var free = false
var step = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	ringsprite.play("ring") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if free:
		position.x += step

	
func _integrate_forces(state):
	if start:
		linear_velocity = Vector2(cos(-angled),sin(-angled)) * FORCE
		FORCE.y*=0.9
		#if FORCE < 50 and not free:
			##if linear_velocity.x < 0:
				##step *= -1
			#free = true
			#await get_tree().create_timer(2).timeout
			#blink(10)
			#await get_tree().create_timer(5).timeout
			#queue_free()
func shoot(angle,worthvalue):
	worth = worthvalue
	start = true
	angled = angle

func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if cancollect:
			area2d.set_deferred("monitoring",false)
			if self != null:
				get_parent().get_parent().get_node("CanvasLayer/ActUIController").change_rings(worth)
			ringsprite.play("particles") 

func blink(times:int):
	for time in range(times):
		ringsprite.modulate.a = 0
		await get_tree().create_timer(0.2).timeout
		ringsprite.modulate.a = 1
		await get_tree().create_timer(0.2).timeout

func _on_animated_sprite_2d_animation_finished():
	if ringsprite.animation == "particles":
		queue_free()

func disappear():
	await get_tree().create_timer(3).timeout
	blink(10)
	await get_tree().create_timer(5).timeout
	queue_free()
