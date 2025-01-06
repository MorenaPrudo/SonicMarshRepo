extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_size(type:String="regular"):
	if type == "rolling":
		position = Vector2(0,9)
		shape.radius = 15
		shape.height = 30
		print("now rolling")
	elif type == "lookingdown":
		position = Vector2(2,12)
		shape.radius = 12
		shape.height = 24
		print("now ld")
	else:
		position = Vector2(2,5)
		shape.radius = 13
		shape.height = 36
		print("now regular")
