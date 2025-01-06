extends Path2D
var closesttomarker
var distancetomarker 
@onready var marker = $Marker2D
var markerposition
const step = 5
var should_shoot = false
var star 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select_to_shoot():
	print("shouldnot be happening")
	markerposition = marker.global_position
	if get_child_count() > 1:
		for child in get_children():
			distancetomarker = 100000
			if child is PathFollow2D:
				if (distancetomarker > child.global_position.distance_to(markerposition)) and is_instance_valid(child) and child:
					distancetomarker = child.global_position.distance_to(markerposition)
					closesttomarker = child
		print("holup")
		star = closesttomarker.get_child(0)
		star.canhurt = true
		star.reparent(get_parent().get_parent(),true)
		star.shoot()
		closesttomarker.free()
		
func switch():
	for child in get_children():
			if child is PathFollow2D:
				child.get_child(0).tweendistance *= -1
				child.step *= -1 
