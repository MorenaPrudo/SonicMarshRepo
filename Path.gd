extends Node2D
@export var secondstocomplete : float = 3
@export var speedwhencomplete : int = 300
@onready var sprite = $Path2D/PathFollow2D/JumpAnim
@onready var remotetransform = $Path2D/PathFollow2D/RemoteTransform2D
@onready var pathfollow = $Path2D/PathFollow2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
			body.animsprite.play("jump")
			print("daikoku ren")
			pathfollow.progress_ratio = 0
			body.visible = false
			sprite.visible = true
			sprite.play()
			sprite.get_node("LoopSprite/CollisionShape2D").set_deferred("disabled",false)
			remotetransform.update_position = true
			body.stopmovement(15)
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(pathfollow, "progress_ratio",1, secondstocomplete)
			await tween.finished
			remotetransform.update_position = false
			body.startmovement(speedwhencomplete)
			body.visible = true
			body.animsprite.animation = "jump"
			body.rolling = true
			sprite.visible = false


func _on_end_body_entered(body):
	if body is CharacterBody2D:
		if body.rolling:
			pathfollow.progress_ratio = 0.99
			body.visible =false
			sprite.visible = true
			sprite.play()
			remotetransform.update_position = true
			body.stopmovement(15)
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(pathfollow, "progress_ratio",0, secondstocomplete)
			remotetransform.update_position = false
			body.startmovement(speedwhencomplete)
			body.visible = true
			body.animsprite.animation = "jump"
			body.rolling = true
			sprite.visible = false
