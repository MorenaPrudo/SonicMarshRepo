extends Node2D
var playeroncurve : bool
var playerdirection:int
const jumpforce = -1000
const curve_direction = 1
var player
var maxdistance
var playerdistance
@export var tipposition :Marker2D
@export var bottomposition:Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	maxdistance = sqrt((tipposition.global_position.x - bottomposition.global_position.x)**2 + (bottomposition.global_position.y - tipposition.global_position.y )**2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playeroncurve:
		print("should change angle")
		playerdistance = sqrt((player.global_position.x - bottomposition.global_position.x)**2 + (bottomposition.global_position.y - player.global_position.y )**2)
		player.animsprite.rotation = max(-PI/2 * playerdistance/maxdistance,-PI/2)
		if player.global_position.x < bottomposition.global_position.x:
			player.animsprite.rotation = 0


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		print("entered")
		player = body
		if body.direction == curve_direction:
			playeroncurve = true

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		playeroncurve = false
		if (body.currentdirection == curve_direction or body.direction == 0) and (body.global_position.x > tipposition.global_position.x - 5):
			print(jumpforce - body.speed)
