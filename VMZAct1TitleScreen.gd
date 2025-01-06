extends Control

@export var marsh : CharacterBody2D
@export var actUIController : Control
@export var actendhud : Control
@onready var sonicvfx = $"Titlecardvfx(sonicver)-SonicAndMarsh" # x 383  y 668
@onready var blackvfx = $"Titlecardvfx(black)" # x 383  y -31
@onready var vmtitle = $"VibrantMeadowTitleCard-SonicAndMarsh" # x -522  y 276
@onready var zoneact1 = $"ZoneAct1TitleCard-SonicAndMarsh" # x 1306  y 360
@onready var colorrect = $"ColorRect" # x 169  y -554

func _ready():
	actUIController.visible = false
	actendhud.visible = false 
	var tween = create_tween()  # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(colorrect, "position",Vector2(169,-94), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(blackvfx, "position",Vector2(383,260), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonicvfx, "position",Vector2(383,515), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(vmtitle, "position",Vector2(365, 276), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(zoneact1, "position",Vector2(725,360), 1)
	await get_tree().create_timer(1).timeout
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(vmtitle, "position",Vector2(400, 276), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(zoneact1, "position",Vector2(690,360), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(colorrect, "position",Vector2(169,-44), 1)
	await get_tree().create_timer(1).timeout
	actUIController.visible = true 
	actendhud.visible = true 
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(blackvfx, "position",Vector2(383,-31), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sonicvfx, "position",Vector2(383,668), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(colorrect, "position",Vector2(169,3760), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(vmtitle, "position",Vector2(1477, 276), 1)
	tween = create_tween() # - new tween
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(zoneact1, "position",Vector2(-725,360), 1)
	await tween.finished
	marsh.startmovement(0) 
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	blackvfx.region_rect.position += Vector2(7, 0)
	sonicvfx.region_rect.position += Vector2(7, 0)
	
