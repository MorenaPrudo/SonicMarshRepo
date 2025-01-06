extends Node2D
@onready var animsprite = $RingMonitor
@onready var powersprite = $Power
@onready var Collision = $Collision
@onready var smokeexplosion = $SmokeExplosion
@export var Ringamount = 10
var broken = false
# Called when the node enters the scene tree for the first time.
func _ready():
	powersprite.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and not broken:
		print("entered area")
		print(body.jumping) 
		if body.jumping or body.animsprite.animation  == "spindash" or body.animsprite.animation  == "jump":
			$AudioStreamPlayer.play()
			broken = true
			animsprite.play("broken")
			Collision.apply_impulse(body.velocity * 2)
			Collision.queue_free()
			smokeexplosion.visible=true
			smokeexplosion.play("default")
			powersprite.stop()
			animsprite.frame = 0
			var tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(powersprite, "position:y", powersprite.position.y - 40, 1)
			get_parent().get_node("CanvasLayer/ActUIController").change_rings(Ringamount)
			await tween.finished
			powersprite.visible = false


func _on_spindash_area_body_entered(body):
	if body is CharacterBody2D:
		print(body.velocity.x)
		print(body.rolling)
		if (body.rolling and abs(body.velocity.x) > 220):
			if not broken:
				Collision.apply_impulse(body.velocity*2)
				Collision.queue_free()
				broken = true
				smokeexplosion.visible=true
				smokeexplosion.play("default")
				powersprite.stop()
				animsprite.frame = 0
				var tween = create_tween()
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_CUBIC)
				tween.tween_property(powersprite, "position:y", powersprite.position.y - 40, 2)
				get_parent().get_node("CanvasLayer/ActUIController").change_rings(Ringamount)
				smokeexplosion.play("default")
				await tween.finished
				powersprite.visible = false


func _on_smoke_explosion_animation_finished():
	smokeexplosion.visible = false
