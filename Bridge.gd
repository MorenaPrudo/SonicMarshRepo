extends Node2D
var bridgedistance
@export var lognum : int
@export var endofbridge : Marker2D
var numoflogs
var player
var onbridge = false
var closestlog
var closestlogdistance =0
const ydistancetolower = 10
@export var collisiony = 16
# Called when the node enters the scene tree for the first time.
func _ready():
	bridgedistance = abs(global_position.x - endofbridge.global_position.x)
	numoflogs = ceil(bridgedistance/16.0)
	for num in numoflogs:
		var log = get_child(num+1)
		log.visible = true
		log.global_position.x = global_position.x + 16 * num
	


func _process(delta):
	if onbridge:
		closestlogdistance = 10000
		for num in numoflogs:
			var log = get_child(num+1)
			if log is Sprite2D:
				if closestlogdistance > abs(log.global_position.x - player.global_position.x):
					closestlogdistance = abs(log.global_position.x - player.global_position.x) 
					closestlog = num + 2
		lowerlog(closestlog,15)


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		player = body
		onbridge = true
		$Floor.position.y = collisiony

func lowerlog(numofclosestlog:int,numberoflogsaffected:int):
	if get_child(numofclosestlog) is Sprite2D:
		get_child(numofclosestlog).position.y = ydistancetolower
	var i = 0
	var logswithdifferentyvalues = (numberoflogsaffected-1)/2.0
	for num in range(logswithdifferentyvalues):
		if get_child(numofclosestlog - num - 1) is Sprite2D:
			get_child(numofclosestlog - num - 1).position.y = (ydistancetolower/logswithdifferentyvalues) * (logswithdifferentyvalues - num -1)**1.4
	for num in range(logswithdifferentyvalues):
		if get_child(numofclosestlog - num - 1) is Sprite2D:
			get_child(numofclosestlog + num - 1).position.y = (ydistancetolower/logswithdifferentyvalues) * (logswithdifferentyvalues - num -1)**1.4


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		print("higggfcg")
		onbridge = false
		for child in get_children():
			if child is Sprite2D:
				child.position.y = 0
		await get_tree().create_timer(0.1).timeout
		$Floor.position.y = collisiony
