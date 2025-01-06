extends Control
@export var marsh:CharacterBody2D
@onready var mountain1 = $"VmzMountain1-SonicAndMarsh"
@onready var mountain2 = $"VmzMountain2-SonicAndMarsh"
@onready var mountain3 = $"VmzMountain3-SonicAndMarsh"
@onready var mountain4 = $"TtzMountain4-SonicAndMarsh"
@onready var mountain5 = $"TtzMountain5-SonicAndMarsh"
@onready var mountain6 = $"TtzMountain6-SonicAndMarsh"
@onready var snow1 = $"TtzSnow1-SonicAndMarsh"
@onready var snow2 = $"TtzSnow2-SonicAndMarsh"
@onready var snow3 = $"TtzSnow3-SonicAndMarsh"
@onready var snow4 = $"TtzSnow4-SonicAndMarsh"
@onready var snow5 = $"TtzSnow5-SonicAndMarsh"
@onready var snow6 = $"TtzSnow6-SonicAndMarsh"
@onready var snow7 = $"TtzSnow7-SonicAndMarsh"
@onready var snow8 = $"TtzSnow8-SonicAndMarsh"
@onready var snow9 = $"TtzSnow9-SonicAndMarsh"
@onready var snow10 = $"TtzSnow10-SonicAndMarsh"
@onready var snow11 = $"TtzSnow11-SonicAndMarsh"

const speed1 = 0.001
const speed2 = 0.002
const speed3 = 0.004
const speed4 = 0.02
const speed5 = 0.03
const speed6 = 0.04

const speed7 = 0.01
const speed8 = 0.02
const speed9 = 0.03
const speed10 = 0.04
const speed11 = 0.05
const speed12 = 0.06
const speed13 = 0.07
const speed14 = 0.09
const speed15 = 0.11
const speed16 = 0.14
const speed17 = 0.17

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mountain1.region_rect.position = Vector2(marsh.position.x*speed1,0)
	mountain2.region_rect.position = Vector2(marsh.position.x*speed2,0)
	mountain3.region_rect.position = Vector2(marsh.position.x*speed3,0)
	mountain4.region_rect.position = Vector2(marsh.position.x*speed4,0)
	mountain5.region_rect.position = Vector2(marsh.position.x*speed5,0)
	mountain6.region_rect.position = Vector2(marsh.position.x*speed6,0)
	
	snow1.region_rect.position = Vector2(marsh.position.x*speed7,0)
	snow2.region_rect.position = Vector2(marsh.position.x*speed8,0)
	snow3.region_rect.position = Vector2(marsh.position.x*speed9,0)
	snow4.region_rect.position = Vector2(marsh.position.x*speed10,0)
	snow5.region_rect.position = Vector2(marsh.position.x*speed11,0)
	snow6.region_rect.position = Vector2(marsh.position.x*speed12,0)
	snow7.region_rect.position = Vector2(marsh.position.x*speed13,0)
	snow8.region_rect.position = Vector2(marsh.position.x*speed14,0)
	snow9.region_rect.position = Vector2(marsh.position.x*speed15,0)
	snow10.region_rect.position = Vector2(marsh.position.x*speed16,0)
	snow11.region_rect.position = Vector2(marsh.position.x*speed17,0)
