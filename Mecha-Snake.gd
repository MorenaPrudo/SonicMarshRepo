extends Node2D
var camerafinalpos : Vector2 = Vector2(38400,-775)
var player
var starteddefeat = false
var arrived = false
var freeze = false
var hp = 8
var bossbodynum
var SNAKEATTACK = false
var SPIKEATTACK = false
var DEFEATED = false
var snakechange = false
@onready var Uicontroller = $"../CanvasLayer/ActUIController"
const step = 2
const minx = 16429
const maxx = 16880
const secondspikeballstart = 1

func _ready():
	randomize_eggman()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEFEATED:
		if !starteddefeat:
			Global.score += 1000
			Uicontroller.change_score()
			Uicontroller.stop_timer()
			$upperball.stop()
			$lowerball.stop()
			starteddefeat = true
			
	elif SNAKEATTACK:
		randomize_eggman()
		$bossBody.snake_attack(snakechange)
		SNAKEATTACK = false
		snakechange = !snakechange
	elif SPIKEATTACK:
		var dir = randi() % 2
		SPIKEATTACK = false
		if randi() % 2 == 0:
			$upperball.start(dir)
			await get_tree().create_timer(secondspikeballstart).timeout
			if dir == 1:
				$lowerball.start(-1)
			else:
				$lowerball.start(1)
			await get_tree().create_timer($lowerball.movetime).timeout
			SNAKEATTACK = true
		else:
			$lowerball.start(dir)
			await get_tree().create_timer(secondspikeballstart).timeout
			if dir == 1:
				$upperball.start(-1)
			else:
				$upperball.start(1)
			await get_tree().create_timer($upperball.movetime).timeout
			SNAKEATTACK = true
			
			
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
		tween.tween_property($"../Audio/OceanPalace", "volume_db",-80, 1)
		if !body.atboss:
			player = body
			body.bossclampmin = Vector2(38200,-9000)
			body.bossclampmax = Vector2(38600,9000)
			print(body.position)
			body.atboss = true
			$"../Audio/Act2Boss".play()
			tween = create_tween()
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property($"../Audio/Act2Boss", "volume_db",0, 1)
			$bossBody.arrive()
			body.remove_camera() 
			print(get_parent().get_node("Camera2D").global_position)
			$BossStart.set_deferred("monitoring",false)
			tween_camera(get_parent().get_node("Camera2D"),camerafinalpos,1)
			

func blink():
	modulate = Color(1,0.5,0.5)
	await get_tree().create_timer(0.3).timeout
	modulate = Color(1,1,1)

func randomize_eggman():
	for node in get_tree().get_nodes_in_group("snakebodies"):
		node.eggman = false
		node.animsprite.play("mechabody")
	bossbodynum = randi_range(1, 5)
	if bossbodynum == 1:
		$bossBody.animsprite.play("mechahead")
		$bossBody.eggman = true
	else:
		get_node("bossBody"+str(bossbodynum)).animsprite.play("mechahead")
		get_node("bossBody"+str(bossbodynum)).eggman = true
