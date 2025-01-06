extends Node2D
@onready var camera = $Camera2D
@onready var rect1 = $ColorRect
@onready var portal = $"Portal-SonicAndMarsh"
@onready var marsh = $Marshfall
@onready var sonic = $Sonicidle
@onready var marshd = $"Camera2D/MarshDialogue-SonicAndMarsh"
@onready var sonicd = $"Camera2D/SonicDialogue-SonicAndMarsh"
@onready var playa = $AudioStreamPlayer
@onready var rect2 = $Camera2D/ColorRect2
@onready var rect3 = $Camera2D/ColorRect3
@onready var rect4 = $Camera2D/ColorRect4
@onready var sonictext = $"Camera2D/DialogueSonic"
@onready var marshtext = $"Camera2D/DialogueMarsh"
var VMZAct1 = preload("res://vmzact1.tscn")
var textarr = ["Do you happen to know anything about a dimensional collision?","Woah, ok...Let's take things step by step. Dimensional collision?", "Someone in this world is trying to pry their way open into mine. It doesn't seem to be for good, either...", "I don't know anything about dimensions, but if its anything evil, it has to be one person―Robotnik!","There's no time to lose, then...","Wait up!"]
var speakerarr = []
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	playa.play()
	portal.play()
	marsh.play("fall")
	sonic.play("idle")
	var tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(camera, "position",Vector2(750,180), 5.5) 
	tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect1, "modulate",Color(1,1,1,0), 5)
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($"AudioStreamPlayer", "volume_db",0, 3)
	await get_tree().create_timer(6.5).timeout
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(portal, "scale",Vector2(1,1), 1.5) 
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "scale",Vector2(-1,1), 0.01)
	await get_tree().create_timer(0.5).timeout 
	sonic.play("push")
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(915,216), 1)
	await get_tree().create_timer(0.8).timeout 
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(930,216), 1.5)
	await get_tree().create_timer(1.2).timeout 
	sonic.play("hurt")
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(1150,216), 0.7)
	tween = create_tween() 
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "modulate",Color(0,0,0,1), 1)
	await get_tree().create_timer(1).timeout
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "position",Vector2(683,216), 0.5) 
	tween = create_tween() 
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "modulate",Color(1,1,1,1), 0.5)
	await get_tree().create_timer(0.5).timeout
	sonic.play("fullspeed")
	marsh.play("idle")
	await get_tree().create_timer(0.1).timeout
	marsh.play("lookuptrans")
	await get_tree().create_timer(0.05).timeout
	marsh.play("lookup")
	await get_tree().create_timer(0.1).timeout
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(portal, "scale",Vector2(0,0), 1.5)
	await get_tree().create_timer(0.5).timeout
	marsh.play("lookuptrans")
	await get_tree().create_timer(0.1).timeout
	marsh.play("idle")
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "scale",Vector2(-1,1), 0.01)
	await get_tree().create_timer(0.6).timeout
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(marsh, "scale",Vector2(1,1), 0.01)
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(camera, "position",Vector2(855,180), 1) 
	await get_tree().create_timer(0.6).timeout
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(1045,216), 0.6)
	await get_tree().create_timer(0.5).timeout
	sonic.play("basicmotion")
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonic, "position",Vector2(1025,216), 0.3) 
	await tween.finished
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
	await tween.finished
	sonictext.visible = true
	marshtext.visible = true
	speakerarr = [marshtext, sonictext, marshtext, sonictext, marshtext, sonictext]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
				var twee = create_tween()
				twee.set_ease(Tween.EASE_OUT)
				twee.set_trans(Tween.TRANS_LINEAR)
				twee.tween_property(marsh, "position",Vector2(1500,216), 1.5)
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
				tweenb = create_tween()
				tweenb.set_ease(Tween.EASE_OUT)
				tweenb.set_trans(Tween.TRANS_LINEAR)
				tweenb.tween_property(camera,"position",Vector2(1021,180), 1.5)
				tweenz = create_tween()
				tweenz.set_ease(Tween.EASE_OUT)
				tweenz.set_trans(Tween.TRANS_LINEAR)
				tweenz.tween_property(sonic,"scale",Vector2(-1,1), 0.01)
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
				await tweenb.finished
				tweenz = create_tween()
				tweenz.set_ease(Tween.EASE_OUT)
				tweenz.set_trans(Tween.TRANS_LINEAR)
				tweenz.tween_property(sonic,"scale",Vector2(1,1), 0.01)
				await tweenz.finished
				Global.checkpointposition = Vector2(-120,100)
				Global.clampposmin = -5000
				Global.clampposmax = 800
				tween = create_tween()
				tween.set_ease(Tween.EASE_OUT)
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property($"AudioStreamPlayer", "volume_db",-80, 1)
				await tween.finished
				get_tree().change_scene_to_packed(VMZAct1)
			
func speak(speakertext:Label,text:String):
	if speakertext.name == "DialogueMarsh":
		sonictext.text = ""
		marshtext.text = text
	else:
		sonictext.text = text
		marshtext.text = ""
	
