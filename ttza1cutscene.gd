extends Node2D
var ttzact1 = preload("res://ttzact1.tscn")
@onready var sonic = $sonic
@onready var marsh = $marsh
@onready var white = $White
@onready var white2 = $White2
@onready var orange = $Orange
@onready var camera = $Camera2D
@onready var whitebg = $WhiteBG
@onready var whitebg2 = $WhiteBG2
@onready var orangebg = $OrangeBG
@onready var colorrect = $ColorRect5
@onready var marshd = $"Camera2D/MarshDialogue-SonicAndMarsh"
@onready var sonicd = $"Camera2D/SonicDialogue-SonicAndMarsh"
@onready var playa = $AudioStreamPlayer
@onready var rect2 = $Camera2D/ColorRect2
@onready var rect3 = $Camera2D/ColorRect3
@onready var rect4 = $Camera2D/ColorRect4
@onready var sonictext = $"Camera2D/DialogueSonic"
@onready var marshtext = $"Camera2D/DialogueMarsh"
@onready var capsule = $Capsule
var textarr = ["A-ok! Bet'cha I'll find Robotnik first!","You're on...but don't regret it when you don't get to beat the hair back in him again!",]
var speakerarr = []
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	playa.play()
	var tween2 = create_tween()
	tween2.set_ease(Tween.EASE_IN)
	tween2.set_trans(Tween.TRANS_LINEAR)
	tween2.tween_property(capsule, "position",Vector2(-278, 241), 1.4)  
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(playa, "volume_db",0, 1)
	marsh.play("basicmotion")
	sonic.play("run")
	await get_tree().create_timer(0.5).timeout
	marsh.play("fullspeed")
	await get_tree().create_timer(2).timeout
	tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(256, 267), 2)  
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "position",Vector2(306, 267), 0.7)
	await get_tree().create_timer(3).timeout
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(white, "modulate",Color(1,1,1,1), 5)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(whitebg, "modulate",Color(1,1,1,1), 5)  
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(orange, "modulate",Color(1,1,1,0), 6)  
	await get_tree().create_timer(7).timeout
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(white2, "modulate",Color(1,1,1,1), 0.1)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(white, "modulate",Color(1,1,1,0), 0.5)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(white2, "position",Vector2(-700,-53), 6)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(whitebg2, "modulate",Color(1,1,1,1), 5)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(whitebg, "modulate",Color(1,1,1,0), 5)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(70, 267), 5)  
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "position",Vector2(120, 267), 5)
	await get_tree().create_timer(5.9).timeout
	marsh.play("skidchange")
	await get_tree().create_timer(0.1).timeout
	sonic.play("skidchange")
	marsh.play("skid")
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "position",Vector2(140, 267), 0.1)
	await get_tree().create_timer(0.1).timeout
	sonic.play("skid")
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(90, 267), 0.1)  
	await get_tree().create_timer(0.1).timeout
	marsh.play("idle")
	await get_tree().create_timer(0.1).timeout
	sonic.play("idle")
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect2, "modulate",Color(1,1,1,1), 0.5)
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect3, "modulate",Color(1,1,1,1), 0.5)
	var tweend = create_tween()
	tweend.set_ease(Tween.EASE_OUT)
	tweend.set_trans(Tween.TRANS_LINEAR)
	tweend.tween_property(rect4, "modulate:a",1, 0.5)
	print("see if this prints")
	await get_tree().create_timer(0.5).timeout
	var tweenc = create_tween()
	tweenc.set_ease(Tween.EASE_OUT)
	tweenc.set_trans(Tween.TRANS_LINEAR)
	tweenc.tween_property(rect4, "position",Vector2(-296,-48), 0.5)
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect3, "size",Vector2(579,110), 0.5)
	var tweenb = create_tween()
	tweenb.set_ease(Tween.EASE_OUT)
	tweenb.set_trans(Tween.TRANS_LINEAR)
	tweenb.tween_property(rect3, "position",Vector2(-275,-40), 0.5)
	await get_tree().create_timer(0.35).timeout
	tweend = create_tween()
	tweend.set_ease(Tween.EASE_OUT)
	tweend.set_trans(Tween.TRANS_LINEAR)
	tweend.tween_property(marshd, "modulate",Color(1,1,1,1), 0.5)
	var tweenz = create_tween()
	tweenz.set_ease(Tween.EASE_OUT)
	tweenz.set_trans(Tween.TRANS_LINEAR)
	tweenz.tween_property(sonicd, "modulate",Color(1,1,1,1), 0.5)
	sonictext.visible = true
	marshtext.visible = true
	speakerarr = [sonictext, marshtext]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	white.region_rect.position += Vector2(10, 0)
	orange.region_rect.position += Vector2(10, 0)
	whitebg.region_rect.position += Vector2(5, 0)
	orangebg.region_rect.position += Vector2(5, 0)
	if Input.is_action_just_pressed("jump"):
		if speakerarr.size() > 0:
			if i < textarr.size():
				speak(speakerarr[i],textarr[i]) 
				i+=1
			else:
				marshtext.visible = false
				var tweend = create_tween()
				tweend.set_ease(Tween.EASE_OUT)
				tweend.set_trans(Tween.TRANS_LINEAR)
				tweend.tween_property(marshd, "modulate",Color(1,1,1,0), 0.5)
				var tweenz = create_tween()
				tweenz.set_ease(Tween.EASE_OUT)
				tweenz.set_trans(Tween.TRANS_LINEAR)
				tweenz.tween_property(sonicd, "modulate",Color(1,1,1,0), 0.5)
				var tweens = create_tween()
				tweens.set_ease(Tween.EASE_OUT)
				tweens.set_trans(Tween.TRANS_LINEAR)
				tweens.tween_property(sonictext, "modulate",Color(1,1,1,0), 0.5)
				await get_tree().create_timer(0.35).timeout
				marsh.play("fullspeed")
				var tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(rect3, "size",Vector2(579,14), 0.5)
				var tweenb = create_tween()
				tweenb.set_ease(Tween.EASE_OUT)
				tweenb.set_trans(Tween.TRANS_LINEAR)
				tweenb.tween_property(rect3, "position",Vector2(-275,66), 0.5)
				var tweenc = create_tween()
				tweenc.set_ease(Tween.EASE_OUT)
				tweenc.set_trans(Tween.TRANS_LINEAR)
				tweenc.tween_property(rect4, "position",Vector2(-296,52), 0.5)
				await get_tree().create_timer(0.5).timeout
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(rect2, "modulate",Color(1,1,1,0), 0.5)
				tweenc = create_tween()
				tweenc.set_ease(Tween.EASE_OUT)
				tweenc.set_trans(Tween.TRANS_LINEAR)
				tweenc.tween_property(rect3, "modulate",Color(1,1,1,0), 0.5)
				tweend = create_tween()
				tweend.set_ease(Tween.EASE_OUT)
				tweend.set_trans(Tween.TRANS_LINEAR)
				tweend.tween_property(rect4, "modulate:a",0, 0.5)
				await get_tree().create_timer(1).timeout
				marsh.play("jump")
				tween = create_tween() 
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property(marsh, "position",Vector2(367, 127), 1.5)  
				await get_tree().create_timer(0.8).timeout
				sonic.play("jump")
				tween = create_tween() 
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property(sonic, "position",Vector2(457, 127),1.5)  
				await get_tree().create_timer(0.4).timeout
				tween = create_tween() 
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_SINE)
				tween.tween_property(sonic, "position",Vector2(497, 370), 1.5)  
				marsh.play("waterglide")
				tween = create_tween() 
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(marsh, "position",Vector2(590, 160), 1)  
				await get_tree().create_timer(0.3).timeout
				tween = create_tween() 
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(colorrect, "modulate",Color(1,1,1,1), 1.3)
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(playa, "volume_db",-80, 1)
				await tween.finished
				Global.checkpointposition = Vector2(687,45)
				Global.clampposmin = -5000
				Global.clampposmax = 1080
				get_tree().change_scene_to_packed(ttzact1)
				

func speak(speakertext:Label,text:String):
	if speakertext.name == "DialogueMarsh":
		sonictext.text = ""
		marshtext.text = text
	else:
		sonictext.text = text
		marshtext.text = ""
