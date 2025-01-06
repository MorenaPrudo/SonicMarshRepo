extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "x " + str(Global.soniclives)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change():
	$Label.text = "x " + str(Global.soniclives)
