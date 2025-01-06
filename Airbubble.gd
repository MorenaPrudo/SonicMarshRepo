extends Node2D
@onready var animsprite = $AnimatedSprite2D
var isabubble = true

func _ready():
	animsprite.play("default")
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position:y",position.y - 20, 60)  
	await get_tree().create_timer(1).timeout
	tweenleft()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		if animsprite.frame == 6:
			body.startwatertimer()
			animsprite.play("pop")
			$"../Audio/Bubble".play()
			$"../Audio/Drowning".stop()
			body.animsprite.play("airgasp")
			await get_tree().create_timer(0.2).timeout
			body.animsprite.play("run")

func _on_animated_sprite_2d_animation_finished():
	if animsprite.animation == "pop":
		queue_free()

func tweenleft():
	if self != null:
		var tweend = create_tween() 
		tweend.set_ease(Tween.EASE_OUT)
		tweend.set_trans(Tween.TRANS_SINE)
		tweend.tween_property(self, "position:x",position.x - 20, 1)  
		await tweend.finished
		tweenright()

func tweenright():
	if self != null:
		var tweenf = create_tween() 
		tweenf.set_ease(Tween.EASE_IN_OUT)
		tweenf.set_trans(Tween.TRANS_LINEAR)
		tweenf.tween_property(self, "position:x",position.x + 20,1)  
		await tweenf.finished
		tweenleft()
