extends Control
@export var marsh:CharacterBody2D
@onready var mountain1 = $"VmzMountain1-SonicAndMarsh"
@onready var mountain2 = $"VmzMountain2-SonicAndMarsh"
@onready var mountain3 = $"VmzMountain3-SonicAndMarsh"
@onready var mountain4 = $"VmzMountain4-SonicAndMarsh"
@onready var mountain5 = $"VmzMountain5-SonicAndMarsh"
@onready var mountain6 = $"VmzMountain6-SonicAndMarsh"
@onready var mountain7 = $"VmzMountain7-SonicAndMarsh"

const speed1 = 0.04
const speed2 = 0.03
const speed3 = 0.15

const speed4 = 0.06
const speed5 = 0.07
const speed6 = 0.09
const speed7 = 0.11

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	mountain1.region_rect.position = Vector2(marsh.position.x*speed1,0)
	mountain2.region_rect.position = Vector2(marsh.position.x*speed2,0)
	mountain3.region_rect.position = Vector2(marsh.position.x*speed3,0)
	mountain4.region_rect.position = Vector2(marsh.position.x*speed4,0)
	mountain5.region_rect.position = Vector2(marsh.position.x*speed5,0)
	mountain6.region_rect.position = Vector2(marsh.position.x*speed6,0)
	mountain7.region_rect.position = Vector2(marsh.position.x*speed7,0)
