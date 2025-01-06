extends Node2D
@export var marsh : CharacterBody2D
@onready var animplayer = $AnimationPlayer
var camerafinalpos : Vector2 = Vector2(16659,-100)
var player
var arrived = false
var MOVELEFT = true
var MOVERIGHT = false
var ATTACK = false
var BEATEN = false
var startedattack = false
var playerunder = false
var laseron = false
var hp = 6
const step = 2
const minx = 16429
const maxx = 16880
@onready var bossbody = $BossBody
@onready var laser = $BossBody/laser
@onready var animsprite = $BossBody/Sprite2D
@onready var deathsprite = $BossBody/DeathSprite
@onready var goalsign  = $"../Goal"
@onready var marshanim = $"../Sonic/AnimatedSprite2D"
@onready var UIcon = $"../CanvasLayer/ActUIController"
@export var spikedplat1 : StaticBody2D
@export var spikedplat2 :StaticBody2D


#TODO: MUSIC <-- oooh didjya see wat i did there


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Goal/GoalSign-SonicAndMarsh".play("spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if BEATEN:
		$BossBody/Hitbox.set_deferred("monitoring",true)
		position.y += step*2.5
	
	elif arrived:
		if MOVELEFT:
			if bossbody.global_position.x < minx:
				MOVERIGHT = true
				MOVELEFT = false
			elif !ATTACK:
				position.x -= step
		if MOVERIGHT:
			if bossbody.global_position.x > maxx:
				MOVERIGHT = false
				MOVELEFT = true
			elif !ATTACK:
				position.x += step
		if ATTACK:
			if startedattack:
				startedattack = false
				print("cmon")
				if animsprite.animation == "default":
					animsprite.animation = "attack"
					animsprite.play()
					await animsprite.animation_finished
					laseron = true
					laser.visible = true
				if laseron:
					ATTACK = false
					if playerunder:
						player.hurt(laser.global_position)
				else:
					await get_tree().create_timer(0.5).timeout
					ATTACK = false

func _on_area_2d_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if !body.atboss:
			var tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/AngelIsland", "volume_db",-80, 2)
			player = body
			body.bossclampmin = Vector2(16450,-9000)
			body.bossclampmax = Vector2(16875, 1348)
			body.get_node("Camera2D").drag_vertical_enabled = false
			body.atboss = true
			$"../Audio/Act1Boss".play()
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/Act1Boss", "volume_db",0, 2)
			body.remove_camera() 
			print(get_parent().get_node("Camera2D").global_position)
			$BossStart.set_deferred("monitoring",false)
			tween_camera(get_parent().get_node("Camera2D"),camerafinalpos,1)
			
			animplayer.play("arrive")
			spikedplat1.arise()
			spikedplat2.arise()
			arrived = true

func tween_camera(camera:Camera2D,move:Vector2,time:int):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "position",move, time)



func _on_radar_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		playerunder = true
		ATTACK = true
		startedattack = true
		print("player went under")
	

func _on_radar_body_exited(body):
	if body.name == "Marsh" or body.name == "Sonic":
		playerunder = false


func _on_hitbox_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		if body.animsprite.animation == "jump":
			if body.global_position.y < bossbody.global_position.y - 2:
				body.lockdirection(true,0.1)
				body.speed = 450
				body.velocity.y = -500
				await get_tree().create_timer(0.2).timeout
				body.longdeccel = false
			hp -= 1
			$"../Audio/BossHurt".play()
			blink()
			if laseron:
				laseron = false
				laser.visible = false
				animsprite.animation = "default"
			if hp == 0:
				Global.score += 1000
				UIcon.change_score()
				UIcon.stop_timer()
				print("boss killed")
				BEATEN = true
				laser.visible = false
				deathsprite.visible = true
				deathsprite.play()
				$"../Audio/BossDefeat".play()
				await get_tree().create_timer(1).timeout
				var tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property($"../Audio/Act1Boss", "volume_db",-80, 2)
				spikedplat1.burial()
				spikedplat2.burial()
				await get_tree().create_timer(2).timeout
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property($"../Audio/BossDefeat", "volume_db",-80, 2)
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property($"../Audio/AngelIsland", "volume_db",-10, 2)
				tween = create_tween()  # - new tween
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(goalsign, "position",Vector2(16659, -7), 2.7)


func _on_sprite_2d_animation_finished():
	pass


func blink():
	print("shdkd")
	animsprite.modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.3).timeout
	animsprite.modulate = Color(1,1,1)


func _on_death_sprite_animation_finished():
		deathsprite.play()
		deathsprite.position = Vector2(randf_range(-25, 25), randf_range(-10, 5))

func _on_goal_body_entered(body):
	if body is CharacterBody2D:
		$"../Audio/ActComplete".play()
		marsh.stopmovement(15)
		var ringbonus = $"../CanvasLayer/ActEndHUD/RingBonusLabel-SonicAndMarsh/Label"
		var timebonus = $"../CanvasLayer/ActEndHUD/TimeBonusLabel-SonicAndMarsh/Label"
		var total = $"../CanvasLayer/ActEndHUD/TotalLabel-SonicAndMarsh/Label"
		ringbonus.text = str(100*UIcon.rings)
		if UIcon.minutecounter == 10 and UIcon.secondcounter >= 2:
			timebonus.text = str(50000)
		elif UIcon.minutecounter == 9 and UIcon.secondcounter <= 30:
			timebonus.text = str(5000)
		elif UIcon.minutecounter == 9 and UIcon.secondcounter >= 31:
			timebonus.text = str(10000)
		elif UIcon.minutecounter == 8 and UIcon.secondcounter <= 30:
			timebonus.text = str(3000)
		elif UIcon.minutecounter == 8 and UIcon.secondcounter >= 31:
			timebonus.text = str(4000)
		elif UIcon.minutecounter == 7 and UIcon.secondcounter <= 30:
			timebonus.text = str(1000)
		elif UIcon.minutecounter == 0 and UIcon.secondcounter == 2:
			timebonus.text = str(100000)
		$"../Goal/GoalSign-SonicAndMarsh".play("sonic")
		marshanim.play("actclear")
		var tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/Sonic(text)actpassed-SonicAndMarsh-1_png", "position",Vector2(480, 120), 0.7)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/Hastext-SonicAndMarsh", "position",Vector2(700, 119), 0.7)
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/Passedtext-SonicAndMarsh", "position",Vector2(566, 200), 0.7) 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/ZoneAct1TitleCard-SonicAndMarsh", "position",Vector2(669, 174), 0.7)
		await get_tree().create_timer(0.8).timeout   
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/TimeBonusLabel-SonicAndMarsh", "position",Vector2(400, 360), 0.2)
		await get_tree().create_timer(0.3).timeout 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/RingBonusLabel-SonicAndMarsh", "position",Vector2(400, 413), 0.2)
		await get_tree().create_timer(0.3).timeout 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/TotalLabel-SonicAndMarsh", "position",Vector2(400, 515), 0.2)
		await get_tree().create_timer(1).timeout 
		$"../Audio/Bonus".play()
		total.text = str(int(timebonus.text)+int(ringbonus.text))
		Global.score += int(timebonus.text)+int(ringbonus.text)
		UIcon.change_score()
		timebonus.text = str(0)
		ringbonus.text = str(0)
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/AngelIsland", "volume_db",0, 0.5)
		await get_tree().create_timer(6).timeout 
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/AngelIsland", "volume_db",-80, 2)
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://vmza2cutscene.tscn")
