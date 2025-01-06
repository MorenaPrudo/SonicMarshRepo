extends Node2D
var vmzact2 = preload("res://vmzact2.tscn")
@onready var sonic = $Sonicbasicmotion
@onready var marsh = $Marshfullspeed
@onready var green = $Green
@onready var orange = $Orange
@onready var camera = $Camera2D
@onready var orange2 = $BackgroundA2/VMZBackground
@onready var marshd = $"Camera2D/MarshDialogue-SonicAndMarsh"
@onready var sonicd = $"Camera2D/SonicDialogue-SonicAndMarsh"
@onready var playa = $AudioStreamPlayer
@onready var rect2 = $Camera2D/ColorRect2
@onready var rect3 = $Camera2D/ColorRect3
@onready var rect4 = $Camera2D/ColorRect4
@onready var sonictext = $"Camera2D/DialogueSonic"
@onready var marshtext = $"Camera2D/DialogueMarsh"
var VMZAct2 = preload("res://vmzact2.tscn")
var textarr = ["Is that so? I'm not surprised―It's hard to keep up with Sonic speed! I do wonder who the first is, though...","If this happens again, you may meet her...", "The more the merrier!", "Besides, what was that...hostile robot you faced off against?","It's one of Robotnik's creations. If you stick around, we have a better chance of finding him and foiling his plans!","...I guess you're right.", "Well, then...Welcome to the team! I'm Sonic the Hedgehog. You?", "I'm Marsh the Cat.", "Alright! Marsh, let's blast ahead!"]
var speakerarr = []
var i = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	playa.play()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($"AudioStreamPlayer", "volume_db",0, 2)
	sonic.play("basicmotion")
	marsh.play("fullspeed")
	await get_tree().create_timer(0.5).timeout
	sonic.play("fullspeed")
	await get_tree().create_timer(2).timeout
	tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "position",Vector2(190, 327), 2)  
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(camera, "position",Vector2(205.4,265.4), 1)  
	await get_tree().create_timer(3).timeout
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(orange, "modulate",Color(1,1,1,1), 5)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(orange2, "modulate",Color(1,1,1,1), 5)
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
	speakerarr = [sonictext, marshtext, sonictext, marshtext, sonictext, marshtext, sonictext, marshtext, sonictext]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	green.region_rect.position += Vector2(5, 0)
	orange.region_rect.position += Vector2(5, 0)
	if Input.is_action_just_pressed("jump"):
		if speakerarr.size() > 0:
			if i < textarr.size():
				speak(speakerarr[i],textarr[i]) 
				i+=1
			else:
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
				tween = create_tween() 
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(sonic, "position",Vector2(630, 327), 1) 
				await get_tree().create_timer(1).timeout
				marsh.play("basicmotion")
				#Global.checkpointposition = 
				tween = create_tween() 
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(camera, "position",Vector2(204.5, 350), 1) 
				tween = create_tween() 
				tween.set_ease(Tween.EASE_IN)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(marsh, "position",Vector2(200, 327), 1) 
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property($"AudioStreamPlayer", "volume_db",-80, 1)
				await tween.finished
				Global.checkpointposition = Vector2(1600,-225)
				Global.clampposmin = -5000
				Global.clampposmax = 780
				get_tree().change_scene_to_packed(vmzact2)
	
func speak(speakertext:Label,text:String):
	if speakertext.name == "DialogueMarsh":
		sonictext.text = ""
		marshtext.text = text
	else:
		sonictext.text = text
		marshtext.text = ""
