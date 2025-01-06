extends StaticBody2D
@onready var capsule = $Capsule
@onready var end = $"../CanvasLayer/End"
@onready var label = $"../CanvasLayer/Label"
@onready var end2 = $"../CanvasLayer/End2"
@onready var UIcon = $"../CanvasLayer/ActUIController"
var titlescreen = preload("res://title_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.1).timeout 
	var tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(end, "modulate",Color(1,1,1,0), 0.1)
	await get_tree().create_timer(2).timeout 
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label, "position",Vector2(439,722), 0.1)
	await get_tree().create_timer(5).timeout 
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(end2, "modulate",Color(1,1,1,0), 0.1)
	capsule.play("closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Marsh":
		capsule.play("opening")
		body.stopmovement(15)
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
		var tween2 = create_tween()  # - new tween
		tween2.set_ease(Tween.EASE_IN)
		tween2.set_trans(Tween.TRANS_LINEAR)
		tween2.tween_property(body, "position:y",position.y + 20, 0.7)
		body.animsprite.play("actclear")
		await get_tree().create_timer(1).timeout
		var tween = create_tween()  # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property($"../CanvasLayer/ActEndHUD/Sonic(text)actpassed-SonicAndMarsh-1_png", "position",Vector2(472, 120), 0.7)
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
		await get_tree().create_timer(10).timeout 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(end, "modulate",Color(1,1,1,1), 2)
		await get_tree().create_timer(2).timeout 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(label, "position",Vector2(439,322), 4)
		await get_tree().create_timer(5).timeout 
		tween = create_tween() # - new tween
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(end2, "modulate",Color(1,1,1,1), 3)
		await get_tree().create_timer(1).timeout 
		total.text = str(int(timebonus.text)+int(ringbonus.text))
		Global.score += int(timebonus.text)+int(ringbonus.text)
		UIcon.change_score()
		timebonus.text = str(0)
		ringbonus.text = str(0)
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_packed(titlescreen)
