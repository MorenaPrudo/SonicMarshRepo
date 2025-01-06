extends Node2D
@onready var ringsprite = $ringsprite
@onready var particles = $particles
@onready var area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ringsprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		area.set_deferred("monitoring",false)
		print(self.name)
		get_parent().get_parent().get_node("CanvasLayer/ActUIController").change_rings(1)
		$"../../Audio/RingCollect".play()
		ringsprite.visible = false
		particles.visible = true
		particles.play()


func _on_particles_animation_finished():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.name == "LoopSprite":
		area.set_deferred("monitoring",false)
		get_parent().get_parent().get_node("CanvasLayer/ActUIController").change_rings(1)
		$"../../Audio/RingCollect".play()
		ringsprite.visible = false
		particles.visible = true
		particles.play()
