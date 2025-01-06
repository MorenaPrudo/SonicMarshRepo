extends Node2D
@onready var audio = $Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	audio.get_node("OceanPalace").play()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($Audio/OceanPalace, "volume_db",0, 1.5)
	await tween.finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
