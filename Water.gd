extends Node2D
@onready var splash = $WaterSplash

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		body.inwater = true
		body.startwatertimer()
		splash.visible = true
		splash.global_position.x = body.global_position.x
		splash.play("default")
		$"../Audio/Splash".play()

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		body.inwater = false
		body.get_node("WaterLabel").visible = false
		body.get_node("WaterParticles").emitting = false
		splash.visible = true
		splash.global_position.x = body.global_position.x
		splash.play("default")
		$"../Audio/Splash".play()
		$"../Audio/Drowning".stop()


func _on_area_2d_area_exited(area):
	if area.get_parent().is_in_group("bubble"):
		area.get_parent().animsprite.play("pop")


func _on_water_splash_animation_finished():
	splash.visible = false
