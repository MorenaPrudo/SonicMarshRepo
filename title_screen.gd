extends Node2D

@onready var sega = $"CanvasGroup/Sega-SonicAndMarsh"
@onready var rect1 = $"CanvasGroup/ColorRect1"
@onready var bg = $"BgTitleScreen"
@onready var ring = $"RingTitleScreen"
@onready var logo = $"LogoTitleScreen"
@onready var anim1 = $"Anim1TitleScreen"
@onready var rect2 = $"ColorRect2"
@onready var rect3 = $"ColorRect3"
@onready var pressstart = $"PressStart"
@onready var copyright = $"Copyright"
@onready var marsh = $"TitleScreenMarsh"
@onready var sonic = $"TitleScreenSonicFingerWave"
@onready var sonicblink = $CanvasGroup/SonicBlink
@onready var marshblink = $CanvasGroup/MarshBlink
@onready var segasound = $SegaSound
@onready var titlemusic = $TitleMusic
var canstart=false
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	segasound.play()
	await get_tree().create_timer(1).timeout
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sega, "modulate",Color(1,1,1,1), 1)
	await get_tree().create_timer(3).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sega, "modulate",Color(1,1,1,0), 1)
	await get_tree().create_timer(2).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(bg, "modulate",Color(1,1,1,1), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(rect1, "modulate",Color(1,1,1,0), 1)
	await get_tree().create_timer(1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(ring, "position",Vector2(571,310), 1) # x 571, y -284
	await get_tree().create_timer(0.5).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(logo, "position",Vector2(571,321), 1) # x 571, y 791
	await get_tree().create_timer(0.2).timeout
	titlemusic.play()
	await get_tree().create_timer(1.3).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(anim1, "modulate",Color(1,1,1,1), 0)
	anim1.play()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bg.region_rect.position += Vector2(10, 0)
	if canstart:
		if Input.is_action_just_pressed("enter"):
			var tweend = create_tween()  # - new tween
			tweend.set_ease(Tween.EASE_IN)
			tweend.set_trans(Tween.TRANS_LINEAR)
			tweend.tween_property(rect3, "modulate",Color(1,1,1,1), 0.8)
			await tweend.finished
			rect3.modulate = Color(1,1,1,1)
			get_tree().change_scene_to_file("res://main menu.tscn")

func logotween():
	var tweens = create_tween()  # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(ring, "position",Vector2(571,350), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(logo, "position",Vector2(571,361), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(marsh, "position",Vector2(686,207), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(sonic, "position",Vector2(430,207), 1)
	await get_tree().create_timer(1).timeout
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(ring, "position",Vector2(571,310), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(logo, "position",Vector2(571,321), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(marsh, "position",Vector2(686,167), 1)
	tweens = create_tween() # - new tween
	tweens.set_ease(Tween.EASE_IN_OUT)
	tweens.set_trans(Tween.TRANS_SINE)
	tweens.tween_property(sonic, "position",Vector2(430,167), 1)
	await tweens.finished
	logotween()
	


func _on_animated_sprite_2d_animation_finished(): #both jumping
	if anim1.animation == "jump":
		var tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(rect2, "modulate",Color(1,1,1,1), 0)
		await get_tree().create_timer(0.1).timeout
		anim1.modulate = Color(1,1,1,0)
		pressstart.modulate = Color(1,1,1,1)
		copyright.modulate = Color(1,1,1,1)
		marsh.modulate = Color(1,1,1,1)
		sonic.modulate = Color(1,1,1,1)
		sonic.play()
		await get_tree().create_timer(0.3).timeout
		tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(rect2, "modulate",Color(1,1,1,0), 1)
		canstart = true
		pressstart.play()
		marshblink.start()
		logotween()
		await get_tree().create_timer(3).timeout
		sonicblink.start()

func _on_marsh_blink_timeout():
	marsh.play("blink")


func _on_title_screen_marsh_animation_finished():
	marsh.play("idle")


func _on_sonic_blink_timeout():
	sonic.play("blink")


func _on_title_screen_sonic_finger_wave_animation_finished():
	sonic.play("idle")
