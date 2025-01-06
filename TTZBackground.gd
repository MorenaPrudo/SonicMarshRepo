extends Control
@onready var vmzc1 = $"VmzClouds1-SonicAndMarsh" # x 383  y 668
@onready var vmzc2 = $"VmzClouds2-SonicAndMarsh" # x 383  y -31
@onready var vmzc3 = $"VmzClouds3-SonicAndMarsh" # x -522  y 276
@onready var vmzc4 = $"VmzClouds4-SonicAndMarsh" # x 1306  y 360


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vmzc1.region_rect.position += Vector2(3.2, 0)
	vmzc2.region_rect.position += Vector2(2.8, 0)
	vmzc3.region_rect.position += Vector2(2.4, 0)
	vmzc4.region_rect.position += Vector2(2, 0)
	
