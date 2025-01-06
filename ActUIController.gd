extends Control
var maxtime = 10 #in minutes
var minutecounter = 9
var secondcounter = 60
var rings = 0
var ringstogetlife = 100
@export var player : CharacterBody2D
@onready var Seconds = $"TimeLabel-SonicAndMarsh/Seconds"
@onready var Minute = $"TimeLabel-SonicAndMarsh/Minute"
@onready var Rings = $"RingsLabel-SonicAndMarsh/RingCounter"
@onready var Score = $"ScoreLabel-SonicAndMarsh-1_png/Label"
@onready var lifelabel = $"../ActEndHUD".get_child(7)
@onready var over = $"../Over"
# Called when the node enters the scene tree for the first time.
func _ready():
	Score.text = str(Global.score)
	await get_tree().create_timer(1).timeout
	if get_parent().get_parent().get_parent().name == "Controller":
		await get_tree().create_timer(1).timeout
	elif get_parent().get_parent().get_parent().name == "TTZACT2": 
		await get_tree().create_timer(3).timeout
	$"TimeLabel-SonicAndMarsh/ActTimer".start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_act_timer_timeout():
	if minutecounter <= 0 and secondcounter <= 1:
		player.timeddeath = true
		player.die()
		over.timetween()
		$"TimeLabel-SonicAndMarsh/ActTimer".stop()
	secondcounter -=1
	if secondcounter == -1:
		minutecounter -= 1
		secondcounter = 59
		Seconds.text = "59"
		Minute.text = str(minutecounter)
	else:
		if secondcounter < 10:
			Seconds.text = "0" + str(secondcounter)
		else:
			Seconds.text = str(secondcounter)
		
func change_rings(amount:int):
	rings+=amount
	if rings >= ringstogetlife:
		ringstogetlife +=100
		if player.name == "Marsh":
			Global.marshlives +=1
			lifelabel.change()
			$"../../Audio/1up".play()
		else:
			Global.soniclives +=1
			lifelabel.change()
			$"../../Audio/1up".play()
	Rings.text = str(rings)
	
func update_rings(value:int):
	rings = value
	Rings.text = str(rings)
	
func change_score():
	Score.text = str(Global.score)
func stop_timer():
	$"TimeLabel-SonicAndMarsh/ActTimer".stop()
