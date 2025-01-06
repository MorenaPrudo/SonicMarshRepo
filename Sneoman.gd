extends Node2D
@onready var animplayer = $AnimationPlayer
var camerafinalpos : Vector2 = Vector2(38815,27)
var player
var SnowballScene = preload("res://snowball.tscn")
var SnowballParry1Scene = preload("res://parry_snowball_1.tscn")
var SnowballParry2Scene = preload("res://parry_snowball_2.tscn")
var arrived = false
var hp = 6
var can_shoot = true
var DEFEATED = false
var wasdefeated = false
const step = 2
const shootcooldown = 2
@onready var headanim = $StaticBody2D3/Head
@onready var goalsign = $"../Goal"
@onready var Uicontroller = $"../CanvasLayer/ActUIController"


# Called when the node enters the scene tree for the first time.
func _ready():
	headanim.play("default") 
	$"../Goal/GoalSign-SonicAndMarsh".play("spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEFEATED:
		DEFEATED = false
		wasdefeated=true
		for num in range(3):
			get_child(num).deathsprite.scale+= Vector2(num*0.5,num*0.5)
			get_child(num).deathsprite.visible = true
			get_child(num).deathsprite.play()
		await get_tree().create_timer(1).timeout
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/BossDefeat", "volume_db",-80, 2)
		tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(goalsign, "position",Vector2(38685, 119), 2.7)
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/IceParadise", "volume_db",0, 2)
	if arrived:
		if can_shoot:
			can_shoot = false
			await get_tree().create_timer(shootcooldown).timeout
			shoot()
func tween_camera(camera:Camera2D,move:Vector2,time:int):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "position",move, time)


func _on_boss_start_body_entered(body):
	if body.name == "Marsh" or body.name == "Sonic":
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/IceParadise", "volume_db",-80, 1)
		if !body.atboss:
			player = body
			body.bossclampmin = Vector2(38597,-9000)
			body.bossclampmax = Vector2(39035, 1348)
			body.atboss = true
			$"../../TTZA1Storage/Camera2D".enabled = false
			body.remove_camera() 
			get_parent().get_node("Camera2D").enabled = true
			$BossStart.set_deferred("monitoring",false)
			tween_camera(get_parent().get_node("Camera2D"),camerafinalpos,1)
			animplayer.play("arrive")
			arrived = true
			$"../Audio/Act1Boss".play()
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/Act1Boss", "volume_db",0, 1)

func blink():
	modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.3).timeout
	modulate = Color(1,1,1)

func hit():
	$"../Audio/BossHurt".play()
	hp-=1
	blink()
	if hp == 0:
		Global.score += 1000
		Uicontroller.change_score()
		Uicontroller.stop_timer()
		DEFEATED = true
		$"../Audio/BossDefeat".play()
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/Act1Boss", "volume_db",-80, 1)
		
func shoot():
	var randnum = randi_range(1,5)
	if randnum < 4:
			var snowball = SnowballScene.instantiate()
			get_parent().add_child(snowball)
			snowball.global_position = global_position
			snowball.shoot(player)
	elif randnum == 4:
		var parrysnowball = SnowballParry1Scene.instantiate()
		parrysnowball.player = player
		get_parent().add_child(parrysnowball)
		parrysnowball.global_position = global_position
	else:
		var parrysnowball = SnowballParry2Scene.instantiate()
		parrysnowball.player = player
		get_parent().add_child(parrysnowball)
		parrysnowball.global_position = global_position
	await get_tree().create_timer(shootcooldown).timeout
	if not wasdefeated:
		shoot()

func _on_goal_body_entered(body):
	if body is CharacterBody2D:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/IceParadise", "volume_db",0, 2)
		await tween.finished
		$"../Audio/ActComplete".play()
		player.stopmovement(15)
		var ringbonus = $"../CanvasLayer/ActEndHUD/RingBonusLabel-SonicAndMarsh/Label"
		var timebonus = $"../CanvasLayer/ActEndHUD/TimeBonusLabel-SonicAndMarsh/Label"
		var total = $"../CanvasLayer/ActEndHUD/TotalLabel-SonicAndMarsh/Label"
		ringbonus.text = str(100*Uicontroller.rings)
		if Uicontroller.minutecounter == 10 and Uicontroller.secondcounter >= 2:
			timebonus.text = str(50000)
		elif Uicontroller.minutecounter == 9 and Uicontroller.secondcounter <= 30:
			timebonus.text = str(5000)
		elif Uicontroller.minutecounter == 9 and Uicontroller.secondcounter >= 31:
			timebonus.text = str(10000)
		elif Uicontroller.minutecounter == 8 and Uicontroller.secondcounter <= 30:
			timebonus.text = str(3000)
		elif Uicontroller.minutecounter == 8 and Uicontroller.secondcounter >= 31:
			timebonus.text = str(4000)
		elif Uicontroller.minutecounter == 7 and Uicontroller.secondcounter <= 30:
			timebonus.text = str(1000)
		elif Uicontroller.minutecounter == 0 and Uicontroller.secondcounter == 2:
			timebonus.text = str(100000)
		await get_tree().create_timer(1).timeout
		$"../Goal/GoalSign-SonicAndMarsh".play("sonic")
		player.animsprite.play("actclear")
		tween = create_tween()  # - new tween
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
		total.text = str(int(timebonus.text)+int(ringbonus.text))
		Global.score += int(timebonus.text)+int(ringbonus.text)
		Uicontroller.change_score()
		timebonus.text = str(0)
		ringbonus.text = str(0)
		$"../Audio/Bonus".play
		await get_tree().create_timer(1).timeout 
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../Audio/IceParadise", "volume_db",-80, 5)
		await get_tree().create_timer(7).timeout 
		Global.checkpointposition = Vector2(600,-270)
		Global.clampposmin = -5000
		Global.clampposmax = 3585
		get_tree().change_scene_to_file("res://ttzact2.tscn")
