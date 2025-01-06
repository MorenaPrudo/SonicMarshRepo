extends Node2D
@onready var pathfollow2d = $Path2D/PathFollow2D
@onready var sprite = $Path2D/PathFollow2D/Ziphook/AnimatedSprite2D
@onready var ziphooksprite = $Path2D/PathFollow2D/Ziphook
@export var remotetransform : RemoteTransform2D
@export var tweentime = 1.5
var onzipline = false
var player
const ziplineresetcooldown = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("jump") and onzipline:
		print("sjsj")
		player.animsprite.play("jump")
		exit_zipline(player)
		player.startmovement(300)
		player.velocity.y -= player.jumpforce
	
func _on_zip_start_body_entered(body):
	if body is CharacterBody2D:
		if pathfollow2d.progress_ratio == 0:
			player = body
			body.isonzipline = true
			remotetransform.update_position = true
			body.visible = false
			body.animsprite.play("hang")
			sprite.visible = true
			if body.name == "Sonic":
				sprite.play("hangtransition2")
			else:
				sprite.play("hangtransition")
			onzipline = true
			body.stopmovement(10)
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(pathfollow2d, "progress_ratio",1, tweentime)
			await tween.finished
			await get_tree().create_timer(ziplineresetcooldown).timeout
			print("should fall now")
			tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(ziphooksprite, "position",ziphooksprite.position + Vector2(0,1000), 2)

func _on_area_2d_body_entered(body):
	pass

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		exit_zipline(body)


func _on_animated_sprite_2d_animation_finished():
	if player.name == "Sonic":
		sprite.play("hang2")
	else:
		sprite.play("hang")

func exit_zipline(body):
	sprite.visible = false
	body.visible = true
	body.isonzipline = false
	onzipline = false
	remotetransform.update_position = false 
	await get_tree().create_timer(ziplineresetcooldown).timeout
	pathfollow2d.progress_ratio = 0
