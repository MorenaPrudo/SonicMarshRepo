extends Node2D
@onready var UIcon = $"../CanvasLayer/ActUIController"
var player
var arrived = false
var ATTACK = false
var VULNERABLE = false
var DEFEATED = false
var currentlydefeated  = false
var currentlyvulnerable = false
var hp = 1
var armcanhurt = false
const camerafinalpos : Vector2 = Vector2(46526,3195)
const handmovedistance = 1390
const handmovespeed = 1.5
const vulnerablecooldown = 10
const fireballs_each_attack = 5
const fireballcooldown = 1
const blinktimes = 5
const handstartpos = Vector2(0,0)
const globalposoffireballs : PackedVector2Array = [Vector2(46372,2932), Vector2(46452,2932), Vector2(46387,2992), Vector2(46685,2992), Vector2(46620,2932), Vector2(46699,2932)]
var FireballScene = preload("res://fireball.tscn")
@export var hand :StaticBody2D
@export var eggmansprite : AnimatedSprite2D
@export var eggman : StaticBody2D
@export var deathsprite : AnimatedSprite2D
@export var leftrect : ColorRect
@export var rightrect : ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func tween_camera(camera:Camera2D,move:Vector2,time:int):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "position",move, time)
	await tween.finished 
	get_parent().get_node("Camera2D").locktoplayery(player)

func _on_boss_start_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/IceCap", "volume_db",-80, 2)
		if !body.atboss:
			player = body
			body.bossclampmin = Vector2(46400,-9000)
			body.bossclampmax = Vector2(46800,9000)
			print(body.position)
			body.atboss = true
			$"../Audio/Act2Boss".play()
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/Act2Boss", "volume_db",0, 2)
			arrive()
			visible = true
			$"../../TTZACT2Storage/Camera2D".enabled = false
			body.remove_camera() 
			get_parent().get_node("Camera2D").enabled = true
			$BossStart.set_deferred("monitoring",false)
			tween_camera(get_parent().get_node("Camera2D"),camerafinalpos,1)

func arrive():
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "position",Vector2(46535,2950), 5)
	await tween.finished
	arrived = true
	await get_tree().create_timer(1).timeout
	ATTACK = true
	armcanhurt = true

func _process(delta):
	if arrived:
		if ATTACK:
			ATTACK = false
			hand.visible = true
			if randi() % 2 == 0:
				hand.position.x = -84
				warn(true)
			else:
				hand.position.x = 65
				warn(false)
			await get_tree().create_timer(1.5).timeout
			var tween = create_tween()  # - new tween
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(hand, "position",hand.position + Vector2(0,handmovedistance), handmovespeed)
			await tween.finished
			hand.get_node("Collision").set_deferred("disabled",false)
			armcanhurt = false
			print("collision should work now")
			for fireball in range(fireballs_each_attack):
				shoot_fireball()
				await get_tree().create_timer(fireballcooldown).timeout
			tween = create_tween()  # - new tween
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(hand, "position",hand.position - Vector2(0,handmovedistance), handmovespeed)
			armcanhurt = true
			hand.get_node("Collision").set_deferred("disabled",true)
			print("collision should not work now")
			await tween.finished
			VULNERABLE = true
		
		if VULNERABLE:
			VULNERABLE = false
			currentlyvulnerable = true
			eggmansprite.play("open")
			await get_tree().create_timer(vulnerablecooldown).timeout
			if !eggmansprite.animation == "close":
				eggmansprite.play("close")
		
		if DEFEATED:
			
			$"../Audio/BossDefeat".play()
			Global.score += 1000
			UIcon.change_score()
			UIcon.stop_timer()
			var tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/Act2Boss", "volume_db",-80, 2)
			currentlydefeated = true
			DEFEATED = false
			ATTACK = false
			VULNERABLE = false
			player.add_camera()
			tween = create_tween()  # - new tween
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(player.get_node("Camera2D"),"position",Vector2(0,-60),1)
			player.bossclampmin = Vector2(0,-9000)
			player.bossclampmax = Vector2(60000,9000)
			hand.get_node("Collision").set_deferred("disabled",true)
			armcanhurt = false
			hand.visible = false
			eggmansprite.play("eggmanburnt")
			eggman.fly()
			eggman.reparent(get_parent(),true)
			await get_tree().create_timer(0.5).timeout
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/BossDefeat", "volume_db",-80, 2)
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/IceCap", "volume_db",0, 2)
			tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(self, "position",position + Vector2(0,5000), 2)
			
func shoot_fireball():
	var fireball = FireballScene.instantiate()
	get_parent().add_child(fireball)
	fireball.global_position = globalposoffireballs[randf_range(0, 5)]
	print(fireball.global_position)
	fireball.shoot(player)

func blink():
	modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.3).timeout
	modulate = Color(1,1,1)

func _on_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if body.animsprite.animation == "jump" and currentlyvulnerable:
			if body.global_position.y < eggman.global_position.y - 2:
				body.lockdirection(true,0.1)
				body.speed = 250
				body.velocity.y = -200
			else:
				body.velocity.y = 200
			hp-=1
			$"../Audio/BossHurt".play()
			blink()
			currentlyvulnerable = false
			eggmansprite.play("close")
			if hp == 0:
				DEFEATED = true
			


func _on_death_animation_finished():
	deathsprite.play()
	deathsprite.position = Vector2(randf_range(-25, 25), randf_range(-10, 5))


func _on_giant_eggman_robo_v_2_eggman_sonic_and_marsh_animation_finished():
	if eggmansprite.animation == "close":
		if not currentlydefeated:
			ATTACK = true


func _on_arm_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if armcanhurt:
			body.hurt(hand.global_position)

func warn(left=true):
	if left:
		for blink in range(blinktimes):
			leftrect.visible = true
			await get_tree().create_timer(0.3).timeout
			leftrect.visible = false
			await get_tree().create_timer(0.3).timeout
	else:
		for blink in range(blinktimes):
			rightrect.visible = true
			await get_tree().create_timer(0.3).timeout
			rightrect.visible = false
			await get_tree().create_timer(0.3).timeout
