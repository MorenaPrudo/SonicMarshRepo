extends Area2D
@onready var sprite = $Path2D/PathFollow2D/Sprite2D
@onready var remotetransform = $Path2D/PathFollow2D/RemoteTransform2D
@onready var pathfollow = $Path2D/PathFollow2D
@export var speed_for_full_loop = 200
var uppassed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	print(uppassed)
	if body is CharacterBody2D and uppassed:
		if body.speed>speed_for_full_loop:
			pathfollow.progress_ratio = 0
			if body.name == "Marsh":
				sprite.animation = body.animsprite.animation
				sprite.visible = true
				body.animsprite.visible = false
				sprite.play()
				remotetransform.update_position = true
				#remotetransform.update_rotation = true
				body.stopmovement(15)
				var tween = create_tween()
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(pathfollow, "progress_ratio",1, 0.7)
				await tween.finished
				remotetransform.update_position = false
				#remotetransform.update_rotation = false
				#tween.tween_property(body, "rotation",0, 0.3)
				body.startmovement(200)
				sprite.visible = false
				body.animsprite.visible = true


func _on_body_exited(body):
	uppassed= false


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		uppassed = true
