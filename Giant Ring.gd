extends Node2D
@onready var animsprite = $AnimatedSprite2D
var cancollect = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_body_entered(body):
	if body is CharacterBody2D:
		if cancollect and not animsprite.is_playing():
			animsprite.play("default")


func _on_animated_sprite_2d_animation_finished():
	if animsprite.animation == "default":
		animsprite.play("loop")
	else:
		queue_free()


func _on_collect_body_entered(body):
	if body is CharacterBody2D and cancollect and animsprite.animation == "loop":
		cancollect = false
		get_parent().get_node("CanvasLayer/ActUIController").change_rings(50)
		animsprite.play("warpshine")
		$"../Audio/WarpShine".play()
